using System;
using System.IO;
using System.Threading;
using System.Management.Automation;
using System.Management.Automation.Runspaces;
using System.Windows.Forms;
static class MusicHost {
 [STAThread] static void Main(){
  bool first;using(var mutex=new Mutex(true,"Local\\DesktopMusicGlass",out first)){
   if(!first)return;
   try{
    var folder=AppDomain.CurrentDomain.BaseDirectory;
    var initial=InitialSessionState.CreateDefault();initial.AuthorizationManager=new AuthorizationManager("DesktopMusic");
    using(var runspace=RunspaceFactory.CreateRunspace(initial)){
     runspace.ApartmentState=ApartmentState.STA;runspace.ThreadOptions=PSThreadOptions.UseCurrentThread;runspace.Open();
     using(var ps=PowerShell.Create()){
      ps.Runspace=runspace;ps.AddCommand(Path.Combine(folder,"Musica.ps1"));ps.Invoke();
      if(ps.HadErrors)throw new Exception(ps.Streams.Error[0].ToString());
     }
    }
   }catch(Exception e){MessageBox.Show(e.Message,"Musica",MessageBoxButtons.OK,MessageBoxIcon.Error);}
  }
 }
}
