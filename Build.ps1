param([switch]$Check)
$ErrorActionPreference='Stop'
$framework=Join-Path $env:WINDIR 'Microsoft.NET\Framework64\v4.0.30319'
$compiler=Join-Path $framework 'csc.exe'
$metadata=Join-Path $env:WINDIR 'System32\WinMetadata'
$automation=Get-ChildItem (Join-Path $env:WINDIR 'Microsoft.NET\assembly\GAC_MSIL\System.Management.Automation\*\System.Management.Automation.dll') | Select-Object -First 1 -ExpandProperty FullName
$dest=Join-Path $PSScriptRoot 'portable';New-Item -ItemType Directory -Path $dest -Force | Out-Null
function Compile($options){& $compiler @options;if($LASTEXITCODE -ne 0){throw 'Compilazione non riuscita'}}
Compile @('/nologo','/target:library',"/out:$dest\MusicRuntime.dll","/r:$metadata\Windows.Media.winmd","/r:$metadata\Windows.Storage.winmd","/r:$metadata\Windows.Foundation.winmd","/r:$framework\System.Runtime.dll","$PSScriptRoot\src\MusicRuntime.cs")
Compile @('/nologo','/target:library',"/out:$dest\DesktopControls.dll","$PSScriptRoot\src\DesktopControls.cs")
Compile @('/nologo','/target:winexe','/platform:x64',"/out:$dest\Musica.exe",'/r:System.Windows.Forms.dll',"/r:$automation","$PSScriptRoot\src\MusicHost.cs")
Copy-Item -LiteralPath (Join-Path $PSScriptRoot 'src\Musica.ps1') -Destination (Join-Path $dest 'Musica.ps1') -Force
if($Check){& (Join-Path $env:WINDIR 'System32\WindowsPowerShell\v1.0\powershell.exe') -NoProfile -ExecutionPolicy Bypass -STA -File (Join-Path $dest 'Musica.ps1') -Check;if($LASTEXITCODE -ne 0){throw 'Verifica non riuscita'}}
Write-Output 'Pronto: portable\Musica.exe'
