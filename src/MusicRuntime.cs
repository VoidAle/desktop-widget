using System;
using System.Threading;
using Windows.Foundation;
using Windows.Media.Control;
using Windows.Storage.Streams;

public sealed class MusicSnapshot {
 public string Title="",Artist="",Source="",Key="",Error="";
 public bool Connected,Playing,CanSeek;
 public double Position,Duration;
 public byte[] Cover;
 public DateTime Sampled=DateTime.UtcNow;
}
public sealed class MusicRuntime : IDisposable {
 readonly object gate=new object();
 volatile bool stopped;
 MusicSnapshot snapshot=new MusicSnapshot();
 GlobalSystemMediaTransportControlsSession session;
 readonly Thread thread;
 public MusicRuntime(){thread=new Thread(Run);thread.IsBackground=true;thread.Name="Music session monitor";thread.SetApartmentState(ApartmentState.MTA);thread.Start();}
 public MusicSnapshot Read(){lock(gate){return snapshot;}}
 T Wait<T>(IAsyncOperation<T> op){int count=0;while(op.Status==AsyncStatus.Started){if(stopped || count++>150)throw new TimeoutException();Thread.Sleep(10);}return op.GetResults();}
 byte[] ReadCover(IRandomAccessStreamReference reference){
  using(var stream=Wait(reference.OpenReadAsync()))using(var reader=new DataReader(stream.GetInputStreamAt(0))){
   uint size=(uint)Math.Min(stream.Size,8*1024*1024);Wait(reader.LoadAsync(size));var data=new byte[(int)size];reader.ReadBytes(data);return data;
  }
 }
 void Run(){
  GlobalSystemMediaTransportControlsSessionManager manager=null;string lastKey="";byte[] cover=null;DateTime retry=DateTime.MinValue;
  while(!stopped){
   try{
    if(manager==null)manager=Wait(GlobalSystemMediaTransportControlsSessionManager.RequestAsync());
    var active=manager.GetCurrentSession();lock(gate){session=active;}
    var next=new MusicSnapshot();
    if(active!=null){
     var properties=Wait(active.TryGetMediaPropertiesAsync());var playback=active.GetPlaybackInfo();var timeline=active.GetTimelineProperties();
     next.Connected=true;next.Title=properties.Title;next.Artist=properties.Artist;next.Source=active.SourceAppUserModelId;
     next.Playing=playback.PlaybackStatus==GlobalSystemMediaTransportControlsSessionPlaybackStatus.Playing;next.CanSeek=playback.Controls.IsPlaybackPositionEnabled;
     next.Duration=timeline.EndTime.TotalSeconds;
     next.Position=timeline.Position.TotalSeconds+(next.Playing?Math.Max(0,(DateTimeOffset.Now-timeline.LastUpdatedTime).TotalSeconds):0);
     next.Key=next.Source+"|"+next.Title+"|"+next.Artist;
     if(next.Key!=lastKey){lastKey=next.Key;cover=null;retry=DateTime.MinValue;}
     next.Cover=cover;next.Sampled=DateTime.UtcNow;
     lock(gate){snapshot=next;}
     // Publish metadata before reading the image, so artwork cannot hold up controls.
     if(cover==null && DateTime.UtcNow>retry){retry=DateTime.UtcNow.AddSeconds(5);try{if(properties.Thumbnail!=null)cover=ReadCover(properties.Thumbnail);}catch{}}
     if(cover!=null){var withCover=new MusicSnapshot{Title=next.Title,Artist=next.Artist,Source=next.Source,Key=next.Key,Connected=true,Playing=next.Playing,CanSeek=next.CanSeek,Duration=next.Duration,Position=next.Position,Sampled=next.Sampled,Cover=cover};lock(gate){snapshot=withCover;}}
    }else{lock(gate){snapshot=next;}lastKey="";cover=null;}
   }catch(Exception e){lock(gate){snapshot=new MusicSnapshot{Error=e.Message};}manager=null;}
   for(int i=0;i<10 && !stopped;i++)Thread.Sleep(25);
  }
 }
 void Command(int command,double fraction){
  GlobalSystemMediaTransportControlsSession target;lock(gate){target=session;}if(target==null)return;
  ThreadPool.QueueUserWorkItem(delegate{
   try{
    IAsyncOperation<bool> op;
    if(command==0)op=target.TryTogglePlayPauseAsync();
    else if(command==1)op=target.TrySkipPreviousAsync();
    else if(command==2)op=target.TrySkipNextAsync();
    else{var tl=target.GetTimelineProperties();op=target.TryChangePlaybackPositionAsync((long)(tl.EndTime.Ticks*Math.Max(0,Math.Min(1,fraction))));}
    // The monitor observes the final state; commands never wait on the UI thread.
    int n=0;while(op.Status==AsyncStatus.Started && n++<100 && !stopped)Thread.Sleep(10);
   }catch{}
  });
 }
 public void Toggle(){Command(0,0);}public void Previous(){Command(1,0);}public void Next(){Command(2,0);}public void Seek(double fraction){Command(3,fraction);}
 public void Dispose(){stopped=true;}
}
