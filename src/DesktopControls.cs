using System;
using System.Runtime.InteropServices;
[ComImport,Guid("BCDE0395-E52F-467C-8E3D-C4579291692E")] class DeviceEnumerator {}
[ComImport,Guid("A95664D2-9614-4F35-A746-DE8DB63617E6"),InterfaceType(ComInterfaceType.InterfaceIsIUnknown)] interface IDevices {
 [PreserveSig]int EnumAudioEndpoints(int flow,int mask,out IntPtr devices);
 [PreserveSig]int GetDefaultAudioEndpoint(int flow,int role,out IDevice device);
}
[ComImport,Guid("D666063F-1587-4E43-81F1-B948E807363F"),InterfaceType(ComInterfaceType.InterfaceIsIUnknown)] interface IDevice {
 [PreserveSig]int Activate(ref Guid iid,int context,IntPtr activation,[MarshalAs(UnmanagedType.IUnknown)]out object instance);
}
[ComImport,Guid("5CDF2C82-841E-4546-9722-0CF74078229A"),InterfaceType(ComInterfaceType.InterfaceIsIUnknown)] interface IVolume {
 [PreserveSig]int RegisterControlChangeNotify(IntPtr notify);[PreserveSig]int UnregisterControlChangeNotify(IntPtr notify);[PreserveSig]int GetChannelCount(out uint count);
 [PreserveSig]int SetMasterVolumeLevel(float level,ref Guid context);[PreserveSig]int SetMasterVolumeLevelScalar(float level,ref Guid context);[PreserveSig]int GetMasterVolumeLevel(out float level);[PreserveSig]int GetMasterVolumeLevelScalar(out float level);
 [PreserveSig]int SetChannelVolumeLevel(uint channel,float level,ref Guid context);[PreserveSig]int SetChannelVolumeLevelScalar(uint channel,float level,ref Guid context);[PreserveSig]int GetChannelVolumeLevel(uint channel,out float level);[PreserveSig]int GetChannelVolumeLevelScalar(uint channel,out float level);
 [PreserveSig]int SetMute([MarshalAs(UnmanagedType.Bool)]bool mute,ref Guid context);[PreserveSig]int GetMute([MarshalAs(UnmanagedType.Bool)]out bool mute);
}
public sealed class DesktopStatus {public bool AudioAvailable,Muted,HasBattery,Charging;public int Volume,Battery;}
public static class DesktopControls {
 [StructLayout(LayoutKind.Sequential)]struct Power{public byte AC,BatteryFlag,Percent,Saving;public uint Seconds,FullSeconds;}
 [DllImport("kernel32.dll")]static extern bool GetSystemPowerStatus(out Power power);
 static void WithVolume(Action<IVolume> action){IDevices devices=null;IDevice device=null;object endpoint=null;try{devices=(IDevices)new DeviceEnumerator();Marshal.ThrowExceptionForHR(devices.GetDefaultAudioEndpoint(0,1,out device));var iid=typeof(IVolume).GUID;Marshal.ThrowExceptionForHR(device.Activate(ref iid,23,IntPtr.Zero,out endpoint));action((IVolume)endpoint);}finally{if(endpoint!=null)Marshal.ReleaseComObject(endpoint);if(device!=null)Marshal.ReleaseComObject(device);if(devices!=null)Marshal.ReleaseComObject(devices);}}
 public static DesktopStatus Read(){var status=new DesktopStatus();try{WithVolume(delegate(IVolume volume){float value;bool muted;Marshal.ThrowExceptionForHR(volume.GetMasterVolumeLevelScalar(out value));Marshal.ThrowExceptionForHR(volume.GetMute(out muted));status.Volume=(int)Math.Round(value*100);status.Muted=muted;status.AudioAvailable=true;});}catch{}Power p;if(GetSystemPowerStatus(out p)){status.HasBattery=p.BatteryFlag!=128 && p.BatteryFlag!=255 && p.Percent!=255;status.Battery=p.Percent;status.Charging=p.AC==1;}return status;}
 public static void SetVolume(int percent){WithVolume(delegate(IVolume volume){var id=Guid.Empty;Marshal.ThrowExceptionForHR(volume.SetMasterVolumeLevelScalar(Math.Max(0,Math.Min(100,percent))/100f,ref id));});}
 public static void SetMute(bool muted){WithVolume(delegate(IVolume volume){var id=Guid.Empty;Marshal.ThrowExceptionForHR(volume.SetMute(muted,ref id));});}
}
