param([switch]$Check)
$ErrorActionPreference='Stop'
Add-Type -AssemblyName PresentationFramework,PresentationCore,WindowsBase
Add-Type -Path (Join-Path $PSScriptRoot 'MusicRuntime.dll')
Add-Type -Path (Join-Path $PSScriptRoot 'DesktopControls.dll')
[xml]$x=@'
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml" Width="390" Height="188" WindowStyle="None" AllowsTransparency="True" Background="Transparent" ResizeMode="NoResize" Topmost="True" Title="Musica" UseLayoutRounding="True">
<Window.Resources><Style TargetType="TextBlock"><Setter Property="Foreground" Value="#F3F3F3"/><Setter Property="FontFamily" Value="Segoe UI"/><Setter Property="FontSize" Value="11"/></Style><Style TargetType="Button">
 <Setter Property="Foreground" Value="#DEDEDE"/><Setter Property="Background" Value="Transparent"/><Setter Property="BorderThickness" Value="0"/><Setter Property="Cursor" Value="Hand"/><Setter Property="Padding" Value="9,5"/><Setter Property="FontFamily" Value="Segoe UI"/><Setter Property="FontSize" Value="10"/>
 <Setter Property="Template"><Setter.Value><ControlTemplate TargetType="Button">
  <Grid x:Name="Motion" RenderTransformOrigin="0.5,0.5"><Grid.RenderTransform><ScaleTransform/></Grid.RenderTransform>
   <Border Background="{TemplateBinding Background}" CornerRadius="9"/>
   <Border x:Name="Hover" Background="White" CornerRadius="9" Opacity="0"/>
   <ContentPresenter Margin="{TemplateBinding Padding}" HorizontalAlignment="Center" VerticalAlignment="Center"/>
  </Grid>
  <ControlTemplate.Triggers>
   <EventTrigger RoutedEvent="MouseEnter"><BeginStoryboard><Storyboard>
    <DoubleAnimation Storyboard.TargetName="Hover" Storyboard.TargetProperty="Opacity" To="0.14" Duration="0:0:0.12"/>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleX)" To="1.06" Duration="0:0:0.14"/>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleY)" To="1.06" Duration="0:0:0.14"/>
   </Storyboard></BeginStoryboard></EventTrigger>
   <EventTrigger RoutedEvent="MouseLeave"><BeginStoryboard><Storyboard>
    <DoubleAnimation Storyboard.TargetName="Hover" Storyboard.TargetProperty="Opacity" To="0" Duration="0:0:0.18"/>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleX)" To="1" Duration="0:0:0.18"/>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleY)" To="1" Duration="0:0:0.18"/>
   </Storyboard></BeginStoryboard></EventTrigger>
   <EventTrigger RoutedEvent="PreviewMouseLeftButtonDown"><BeginStoryboard><Storyboard>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleX)" To="0.92" Duration="0:0:0.06"/>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleY)" To="0.92" Duration="0:0:0.06"/>
   </Storyboard></BeginStoryboard></EventTrigger>
   <EventTrigger RoutedEvent="PreviewMouseLeftButtonUp"><BeginStoryboard><Storyboard>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleX)" To="1.06" Duration="0:0:0.11"/>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleY)" To="1.06" Duration="0:0:0.11"/>
   </Storyboard></BeginStoryboard></EventTrigger>
   <Trigger Property="IsEnabled" Value="False"><Setter TargetName="Motion" Property="Opacity" Value="0.35"/></Trigger>
  </ControlTemplate.Triggers>
 </ControlTemplate></Setter.Value></Setter>
</Style><Style x:Key="Transport" TargetType="Button">
 <Setter Property="Foreground" Value="#DEDEDE"/><Setter Property="Background" Value="Transparent"/><Setter Property="BorderThickness" Value="0"/><Setter Property="Cursor" Value="Hand"/><Setter Property="Padding" Value="9,5"/><Setter Property="FontFamily" Value="Segoe UI"/><Setter Property="FontSize" Value="10"/>
 <Setter Property="Template"><Setter.Value><ControlTemplate TargetType="Button">
  <Grid x:Name="Motion" RenderTransformOrigin="0.5,0.5"><Grid.RenderTransform><ScaleTransform/></Grid.RenderTransform>
   <Border Background="{TemplateBinding Background}" CornerRadius="100"/>
   <Border x:Name="Hover" Background="White" CornerRadius="100" Opacity="0"/>
   <ContentPresenter Margin="{TemplateBinding Padding}" HorizontalAlignment="Center" VerticalAlignment="Center"/>
  </Grid>
  <ControlTemplate.Triggers>
   <EventTrigger RoutedEvent="MouseEnter"><BeginStoryboard><Storyboard>
    <DoubleAnimation Storyboard.TargetName="Hover" Storyboard.TargetProperty="Opacity" To="0.14" Duration="0:0:0.12"/>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleX)" To="1.06" Duration="0:0:0.14"/>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleY)" To="1.06" Duration="0:0:0.14"/>
   </Storyboard></BeginStoryboard></EventTrigger>
   <EventTrigger RoutedEvent="MouseLeave"><BeginStoryboard><Storyboard>
    <DoubleAnimation Storyboard.TargetName="Hover" Storyboard.TargetProperty="Opacity" To="0" Duration="0:0:0.18"/>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleX)" To="1" Duration="0:0:0.18"/>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleY)" To="1" Duration="0:0:0.18"/>
   </Storyboard></BeginStoryboard></EventTrigger>
   <EventTrigger RoutedEvent="PreviewMouseLeftButtonDown"><BeginStoryboard><Storyboard>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleX)" To="0.92" Duration="0:0:0.06"/>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleY)" To="0.92" Duration="0:0:0.06"/>
   </Storyboard></BeginStoryboard></EventTrigger>
   <EventTrigger RoutedEvent="PreviewMouseLeftButtonUp"><BeginStoryboard><Storyboard>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleX)" To="1.06" Duration="0:0:0.11"/>
    <DoubleAnimation Storyboard.TargetName="Motion" Storyboard.TargetProperty="(UIElement.RenderTransform).(ScaleTransform.ScaleY)" To="1.06" Duration="0:0:0.11"/>
   </Storyboard></BeginStoryboard></EventTrigger>
   <Trigger Property="IsEnabled" Value="False"><Setter TargetName="Motion" Property="Opacity" Value="0.35"/></Trigger>
  </ControlTemplate.Triggers>
 </ControlTemplate></Setter.Value></Setter>
</Style></Window.Resources>
<Grid x:Name="GlassRoot">
<Border x:Name="Shell" CornerRadius="32" Padding="24,20,24,16" BorderThickness="1.5" BorderBrush="#FF000000"><Border.Background><LinearGradientBrush StartPoint="0,0" EndPoint="0.65,1"><GradientStop Color="#E62B2B2B"/><GradientStop Color="#E31B1B1B" Offset="0.45"/><GradientStop Color="#F0101010" Offset="1"/></LinearGradientBrush></Border.Background>
<Grid>
<Grid x:Name="Expanded">
 <Grid x:Name="Header" Height="14" VerticalAlignment="Top" Margin="0,-15,0,0" Background="Transparent" Cursor="SizeAll" ToolTip="Trascina per spostare"><TextBlock x:Name="PageTitle" Text="MUSICA" FontSize="8" Foreground="#909090" Visibility="Collapsed"/><StackPanel x:Name="WindowTools" Orientation="Horizontal" HorizontalAlignment="Right" Opacity="0.5"><Button x:Name="Compact" Content="−" Padding="4,0" Width="18" ToolTip="Riduci a pillola"/><Button x:Name="Close" Content="×" Padding="4,0" Width="18" ToolTip="Chiudi"/></StackPanel></Grid>
 <Grid x:Name="Viewport" Height="148" VerticalAlignment="Top" ClipToBounds="True"><Grid.RenderTransform><TranslateTransform x:Name="PageMotion"/></Grid.RenderTransform>
  <StackPanel x:Name="MusicPage">
   <Grid x:Name="TrackRow" Height="64" Background="Transparent"><Grid.ColumnDefinitions><ColumnDefinition Width="82"/><ColumnDefinition/><ColumnDefinition Width="22"/></Grid.ColumnDefinitions>
    <Grid Width="64" Height="64" HorizontalAlignment="Left"><Border x:Name="CoverBack" CornerRadius="7" Background="#14FFFFFF"><TextBlock Text="♫" FontSize="25" HorizontalAlignment="Center" VerticalAlignment="Center"/></Border><Rectangle x:Name="CoverShape" RadiusX="6" RadiusY="6" VerticalAlignment="Center"><Rectangle.Fill><ImageBrush x:Name="Cover" Stretch="Uniform"/></Rectangle.Fill></Rectangle></Grid>
    <StackPanel Grid.Column="1" VerticalAlignment="Center"><TextBlock x:Name="Song" Text="La tua musica" FontSize="14" FontWeight="SemiBold" TextTrimming="CharacterEllipsis"/><TextBlock x:Name="Artist" Text="Avvia un brano sul PC" Foreground="#B8B8B8" Margin="0,3,0,0" TextTrimming="CharacterEllipsis"/><TextBlock x:Name="AppName" Text="In attesa" Foreground="#8E8E8E" FontSize="9" Margin="0,4,0,0"/></StackPanel>
    <StackPanel x:Name="Wave" Grid.Column="2" Orientation="Horizontal" VerticalAlignment="Center" Height="19" Opacity="0.25"><Border x:Name="Bar0" Width="2" Height="6" Background="#BBBBBB" CornerRadius="1" Margin="1"/><Border x:Name="Bar1" Width="2" Height="13" Background="#BBBBBB" CornerRadius="1" Margin="1"/><Border x:Name="Bar2" Width="2" Height="9" Background="#BBBBBB" CornerRadius="1" Margin="1"/><Border x:Name="Bar3" Width="2" Height="17" Background="#BBBBBB" CornerRadius="1" Margin="1"/><Border x:Name="Bar4" Width="2" Height="6" Background="#BBBBBB" CornerRadius="1" Margin="1"/></StackPanel>
   </Grid>
   <Grid Height="16" Margin="0,14,12,0"><Grid.ColumnDefinitions><ColumnDefinition Width="32"/><ColumnDefinition/><ColumnDefinition Width="35"/></Grid.ColumnDefinitions><TextBlock x:Name="Elapsed" Text="0:00" FontSize="9" Foreground="#909090" VerticalAlignment="Center"/><Border x:Name="SeekArea" Grid.Column="1" Background="Transparent" Padding="0,5" Cursor="Hand" ToolTip="Spostati nel brano"><ProgressBar x:Name="Progress" Height="4" Maximum="100" Foreground="#E5E5E5" Background="#3DFFFFFF" BorderThickness="0"><ProgressBar.Template><ControlTemplate TargetType="ProgressBar"><Grid ClipToBounds="True"><Border Background="{TemplateBinding Background}" CornerRadius="2"/><Border x:Name="PART_Track"/><Border x:Name="PART_Indicator" Background="{TemplateBinding Foreground}" CornerRadius="2" HorizontalAlignment="Left"/></Grid></ControlTemplate></ProgressBar.Template></ProgressBar></Border><TextBlock x:Name="Duration" Grid.Column="2" Text="0:00" FontSize="9" Foreground="#909090" HorizontalAlignment="Right" VerticalAlignment="Center"/></Grid>
   <StackPanel Orientation="Horizontal" HorizontalAlignment="Center" Height="44" Margin="0,9,14,0"><Button x:Name="Prev" Style="{StaticResource Transport}" Width="32" Height="32" Background="#12FFFFFF" ToolTip="Brano precedente" Margin="0,0,9,0"><Path Data="M 0,0 L 0,12 M 11,0 L 2,6 11,12 Z" Stroke="#DDDDDD" Fill="#DDDDDD" StrokeThickness="1.4" Width="13" Height="13"/></Button><Button x:Name="Play" Style="{StaticResource Transport}" Width="44" Height="44" Background="#25FFFFFF" ToolTip="Riproduci o metti in pausa" AutomationProperties.Name="Riproduci o metti in pausa"><Grid Width="14" Height="14"><Path x:Name="PlaySymbol" Data="M 2,0 L 13,7 2,14 Z" Fill="#EEEEEE"/><Path x:Name="PauseSymbol" Data="M 2,0 L 5,0 5,14 2,14 Z M 9,0 L 12,0 12,14 9,14 Z" Fill="#EEEEEE" Visibility="Collapsed"/></Grid></Button><Button x:Name="Next" Style="{StaticResource Transport}" Width="32" Height="32" Background="#12FFFFFF" ToolTip="Brano successivo" Margin="9,0,0,0"><Path Data="M 12,0 L 12,12 M 1,0 L 10,6 1,12 Z" Stroke="#DDDDDD" Fill="#DDDDDD" StrokeThickness="1.4" Width="13" Height="13"/></Button></StackPanel>
  </StackPanel>
  <StackPanel x:Name="ControlsPage" Visibility="Collapsed" Margin="0,6,14,0">
   <Grid Margin="0,0,0,10"><TextBlock Text="Volume del PC" FontSize="15" FontWeight="SemiBold"/><TextBlock x:Name="VolumeLabel" Text="—" Foreground="#CCCCCC" HorizontalAlignment="Right" FontSize="14"/></Grid>
   <Slider x:Name="Volume" Minimum="0" Maximum="100" Value="50" Height="27" ToolTip="Volume generale del PC"><Slider.Template><ControlTemplate TargetType="Slider"><Grid Background="Transparent" Height="26"><Border Height="5" CornerRadius="3" Background="#30FFFFFF" VerticalAlignment="Center" Margin="6,0"/><Track x:Name="PART_Track" Minimum="{TemplateBinding Minimum}" Maximum="{TemplateBinding Maximum}" Value="{TemplateBinding Value}"><Track.DecreaseRepeatButton><RepeatButton Command="Slider.DecreaseLarge" Focusable="False"><RepeatButton.Template><ControlTemplate TargetType="RepeatButton"><Border Height="5" CornerRadius="3" Background="#DDDDDD" VerticalAlignment="Center"/></ControlTemplate></RepeatButton.Template></RepeatButton></Track.DecreaseRepeatButton><Track.Thumb><Thumb Width="14" Height="14"><Thumb.Template><ControlTemplate TargetType="Thumb"><Ellipse Fill="#F5F5F5"/></ControlTemplate></Thumb.Template></Thumb></Track.Thumb><Track.IncreaseRepeatButton><RepeatButton Command="Slider.IncreaseLarge" Focusable="False"><RepeatButton.Template><ControlTemplate TargetType="RepeatButton"><Border Background="Transparent"/></ControlTemplate></RepeatButton.Template></RepeatButton></Track.IncreaseRepeatButton></Track></Grid></ControlTemplate></Slider.Template></Slider>
   <Grid Margin="0,10,0,0"><Button x:Name="Mute" Content="Disattiva audio" Background="#20FFFFFF" HorizontalAlignment="Left" Padding="13,8"/><StackPanel HorizontalAlignment="Right" VerticalAlignment="Center"><TextBlock x:Name="PowerLabel" Text="Alimentazione PC" FontSize="11" Foreground="#CCCCCC" HorizontalAlignment="Right"/><TextBlock x:Name="PowerDetail" Text="Collegato alla corrente" FontSize="9" Foreground="#939393" Margin="0,3,0,0" HorizontalAlignment="Right"/></StackPanel></Grid>
  </StackPanel>
  <StackPanel x:Name="TimerPage" Visibility="Collapsed" Margin="0,3,14,0">
   <Grid Height="65"><StackPanel><TextBlock x:Name="Countdown" Text="25:00" FontSize="41" FontWeight="Light"/><TextBlock x:Name="TimerHint" Text="Pronto quando vuoi" FontSize="9" Foreground="#A0A0A0"/></StackPanel><StackPanel HorizontalAlignment="Right" VerticalAlignment="Center"><TextBlock Text="DURATA · MINUTI" FontSize="8" Foreground="#A0A0A0" HorizontalAlignment="Center" Margin="0,0,0,5"/><StackPanel Orientation="Horizontal"><Button x:Name="Less" Content="−" Width="25" Padding="4"/><Border CornerRadius="8" Background="#1CFFFFFF" BorderBrush="#0CFFFFFF" BorderThickness="1"><TextBox x:Name="Minutes" Text="25" Width="42" Height="28" MaxLength="4" HorizontalContentAlignment="Center" VerticalContentAlignment="Center" Background="Transparent" Foreground="White" BorderThickness="0" FontFamily="Segoe UI" FontSize="13" ToolTip="Scegli da 1 a 1440 minuti"/></Border><Button x:Name="More" Content="+" Width="25" Padding="4"/></StackPanel></StackPanel></Grid>
   <StackPanel Orientation="Horizontal" Margin="0,6,0,8"><Button x:Name="Preset5" Content="5 min" Background="#10FFFFFF" Padding="10,4" Margin="0,0,5,0"/><Button x:Name="Preset15" Content="15 min" Background="#10FFFFFF" Padding="10,4" Margin="0,0,5,0"/><Button x:Name="Preset25" Content="25 min" Background="#10FFFFFF" Padding="10,4" Margin="0,0,5,0"/><Button x:Name="Preset45" Content="45 min" Background="#10FFFFFF" Padding="10,4"/></StackPanel>
   <Grid Height="31"><Button x:Name="Focus" Content="Avvia timer" Width="115" Background="#E9FFFFFF" Foreground="#141414" FontWeight="SemiBold" HorizontalAlignment="Left"/><Button x:Name="Reset" Content="Ricomincia" HorizontalAlignment="Right" Background="#12FFFFFF" Padding="12,5"/></Grid>
  </StackPanel>
 </Grid>
 <StackPanel Orientation="Vertical" HorizontalAlignment="Right" VerticalAlignment="Center" Margin="0,0,-16,0"><Button x:Name="NavMusic" Width="4" Height="10" Padding="0" Margin="0,2" ToolTip="Musica · scorri per cambiare" AutomationProperties.Name="Musica"/><Button x:Name="NavTimer" Width="4" Height="4" Padding="0" Margin="0,2" ToolTip="Timer · scorri per cambiare" AutomationProperties.Name="Timer"/><Button x:Name="NavControls" Width="4" Height="4" Padding="0" Margin="0,2" ToolTip="Volume · scorri per cambiare" AutomationProperties.Name="Volume"/></StackPanel>
</Grid>
<Grid x:Name="Mini" Visibility="Collapsed" Background="Transparent" Cursor="Hand" ToolTip="Clicca per riaprire · trascina per spostare"><Grid.ColumnDefinitions><ColumnDefinition Width="42"/><ColumnDefinition/><ColumnDefinition Width="32"/></Grid.ColumnDefinitions><Ellipse x:Name="MiniBack" Width="30" Height="30" HorizontalAlignment="Left" Fill="#14FFFFFF"/><Ellipse x:Name="MiniShape" Width="30" Height="30" HorizontalAlignment="Left"><Ellipse.Fill><ImageBrush x:Name="MiniCover" Stretch="UniformToFill"/></Ellipse.Fill></Ellipse><TextBlock x:Name="MiniSong" Grid.Column="1" Margin="0,0,8,0" Text="La tua musica" FontWeight="SemiBold" FontSize="11" TextTrimming="CharacterEllipsis" VerticalAlignment="Center"/><StackPanel x:Name="MiniWave" Grid.Column="2" Orientation="Horizontal" VerticalAlignment="Center" Height="20" Opacity="0.25"><Border x:Name="MiniBar0" Width="2" Height="6" Background="#DDDDDD" CornerRadius="1" Margin="1.4,0"/><Border x:Name="MiniBar1" Width="2" Height="6" Background="#DDDDDD" CornerRadius="1" Margin="1.4,0"/><Border x:Name="MiniBar2" Width="2" Height="6" Background="#DDDDDD" CornerRadius="1" Margin="1.4,0"/><Border x:Name="MiniBar3" Width="2" Height="6" Background="#DDDDDD" CornerRadius="1" Margin="1.4,0"/><Border x:Name="MiniBar4" Width="2" Height="6" Background="#DDDDDD" CornerRadius="1" Margin="1.4,0"/></StackPanel></Grid>
</Grid></Border>
<Grid x:Name="Reflections" IsHitTestVisible="False" Opacity="0.45"><Grid.Clip><RectangleGeometry x:Name="ReflectionClip" RadiusX="32" RadiusY="32" Rect="0,0,390,188"/></Grid.Clip><Ellipse Width="230" Height="150" HorizontalAlignment="Left" VerticalAlignment="Top"><Ellipse.RenderTransform><TranslateTransform x:Name="GlowMotion" X="-80" Y="-60"/></Ellipse.RenderTransform><Ellipse.Fill><RadialGradientBrush><GradientStop Color="#12FFFFFF"/><GradientStop Color="#00FFFFFF" Offset="1"/></RadialGradientBrush></Ellipse.Fill></Ellipse></Grid>
</Grid></Window>

'@
$w=[Windows.Markup.XamlReader]::Load((New-Object System.Xml.XmlNodeReader $x))
$ui=@{};$x.SelectNodes('//*') | ForEach-Object {$n=$_.GetAttribute('Name','http://schemas.microsoft.com/winfx/2006/xaml');if($n){$ui[$n]=$w.FindName($n)}}
$data=Join-Path $env:LOCALAPPDATA 'AuraWidgets';New-Item -ItemType Directory $data -Force | Out-Null
$prefs=Join-Path $data 'settings.json';$script:minutes=25
if(Test-Path $prefs){try{$v=(Get-Content $prefs -Raw | ConvertFrom-Json).Minutes;if($v -ge 1 -and $v -le 1440){$script:minutes=[int]$v}}catch{}}
$ui.Minutes.Text=[string]$script:minutes;$script:remaining=60*$script:minutes;$script:focusing=$false
$position=Join-Path $data 'position.json';$w.Left=[Windows.SystemParameters]::WorkArea.Right-410;$w.Top=45
# WPF positions are desktop coordinates and may be negative on other monitors.
if(Test-Path $position){try{$saved=Get-Content $position -Raw | ConvertFrom-Json;$left=[double]$saved.X;$top=[double]$saved.Y;$vx=[Windows.SystemParameters]::VirtualScreenLeft;$vy=[Windows.SystemParameters]::VirtualScreenTop;$vr=$vx+[Windows.SystemParameters]::VirtualScreenWidth;$vb=$vy+[Windows.SystemParameters]::VirtualScreenHeight;if($left -lt $vr -and ($left+$w.Width) -gt $vx -and $top -lt $vb -and ($top+$w.Height) -gt $vy){$w.Left=$left;$w.Top=$top}}catch{}}
$ui.Header.Add_MouseLeftButtonDown({$obj=$_.OriginalSource;while($obj -and $obj -isnot [Windows.Controls.Button]){$obj=[Windows.Media.VisualTreeHelper]::GetParent($obj)};if(-not $obj){$w.DragMove()}})
$ui.TrackRow.Add_MouseLeftButtonDown({$w.DragMove()});$ui.Close.Add_Click({$w.Close()})
function Animate($obj,$prop,$value,$ms=180){$a=New-Object Windows.Media.Animation.DoubleAnimation;$a.To=$value;$a.Duration=[TimeSpan]::FromMilliseconds($ms);$ease=New-Object Windows.Media.Animation.CubicEase;$ease.EasingMode='EaseOut';$a.EasingFunction=$ease;$obj.BeginAnimation($prop,$a)}
$script:compactMode=$false;$script:page=0;$script:lastWheel=[datetime]::MinValue
function Set-Page($index,$direction=1,$motion=$true){
 $script:page=(($index%3)+3)%3
 $ui.MusicPage.Visibility=if($script:page -eq 0){'Visible'}else{'Collapsed'};$ui.ControlsPage.Visibility=if($script:page -eq 2){'Visible'}else{'Collapsed'};$ui.TimerPage.Visibility=if($script:page -eq 1){'Visible'}else{'Collapsed'}
 $ui.PageTitle.Text=@('MUSICA','TIMER','VOLUME')[$script:page];$ui.PageTitle.Visibility=if($script:page -eq 0){'Collapsed'}else{'Visible'}
 $i=0;foreach($name in @('NavMusic','NavTimer','NavControls')){$ui[$name].Background=if($i -eq $script:page){'#BBBBBB'}else{'#505050'};$ui[$name].Foreground=if($i -eq $script:page){'#FFFFFF'}else{'#8F8F8F'};$ui[$name].Height=if($i -eq $script:page){10}else{4};$i++}
 if($motion -and -not $script:compactMode){$ui.Viewport.BeginAnimation([Windows.UIElement]::OpacityProperty,$null);$ui.Viewport.Opacity=0.3;Animate $ui.Viewport ([Windows.UIElement]::OpacityProperty) 1 180;$ui.PageMotion.BeginAnimation([Windows.Media.TranslateTransform]::YProperty,$null);$ui.PageMotion.Y=10*$direction;Animate $ui.PageMotion ([Windows.Media.TranslateTransform]::YProperty) 0 210}
}
function Set-Compact($value,$motion=$true){
 $script:compactMode=$value;$ui.Expanded.Visibility=if($value){'Collapsed'}else{'Visible'};$ui.Mini.Visibility=if($value){'Visible'}else{'Collapsed'};$ui.Shell.Padding=if($value){[Windows.Thickness]::new(9)}else{[Windows.Thickness]::new(24,20,24,16)}
 $ui.Shell.CornerRadius=[Windows.CornerRadius]::new($(if($value){25}else{32}));$ui.ReflectionClip.RadiusX=if($value){25}else{32};$ui.ReflectionClip.RadiusY=$ui.ReflectionClip.RadiusX;$width=if($value){256}else{390};$height=if($value){50}else{188}
 # Preserve the same desktop position while changing size, on every monitor.
 if($motion){Animate $w ([Windows.FrameworkElement]::WidthProperty) $width 200;Animate $w ([Windows.FrameworkElement]::HeightProperty) $height 200}
 else{$w.BeginAnimation([Windows.FrameworkElement]::WidthProperty,$null);$w.BeginAnimation([Windows.FrameworkElement]::HeightProperty,$null);$w.Width=$width;$w.Height=$height}
}
$ui.Compact.Add_Click({Set-Compact $true})
$ui.Mini.Add_MouseLeftButtonDown({$left=$w.Left;$top=$w.Top;$w.DragMove();if([math]::Abs($w.Left-$left)+[math]::Abs($w.Top-$top) -lt 3){Set-Compact $false}})
$menu=New-Object Windows.Controls.ContextMenu;$open=New-Object Windows.Controls.MenuItem;$open.Header='Apri';$open.Add_Click({Set-Compact $false});$quit=New-Object Windows.Controls.MenuItem;$quit.Header='Chiudi';$quit.Add_Click({$w.Close()});$null=$menu.Items.Add($open);$null=$menu.Items.Add($quit);$ui.Mini.ContextMenu=$menu
$ui.NavMusic.Add_Click({Set-Page 0});$ui.NavTimer.Add_Click({Set-Page 1});$ui.NavControls.Add_Click({Set-Page 2})
$w.Add_PreviewMouseWheel({$_.Handled=$true;if($script:compactMode){return};$now=[datetime]::UtcNow;if(($now-$script:lastWheel).TotalMilliseconds -lt 220){return};$script:lastWheel=$now;$direction=if($_.Delta -lt 0){1}else{-1};Set-Page ($script:page+$direction) $direction})
$w.Add_SizeChanged({$ui.ReflectionClip.Rect=[Windows.Rect]::new(0,0,[math]::Max(1,$w.ActualWidth),[math]::Max(1,$w.ActualHeight))})
$script:mouseX=0.25;$script:mouseY=0.15;$script:lightX=0.25;$script:lightY=0.15
$w.Add_MouseEnter({Animate $ui.WindowTools ([Windows.UIElement]::OpacityProperty) 1 150;Animate $ui.Reflections ([Windows.UIElement]::OpacityProperty) 1 200});$w.Add_MouseLeave({Animate $ui.WindowTools ([Windows.UIElement]::OpacityProperty) 0.5 250;$script:mouseX=0.25;$script:mouseY=0.15;Animate $ui.Reflections ([Windows.UIElement]::OpacityProperty) 0.45 300})
$w.Add_MouseMove({$pt=$_.GetPosition($ui.Shell);$script:mouseX=[math]::Max(0,[math]::Min(1,$pt.X/[math]::Max(1,$ui.Shell.ActualWidth)));$script:mouseY=[math]::Max(0,[math]::Min(1,$pt.Y/[math]::Max(1,$ui.Shell.ActualHeight)))})
$script:clocks=@();0..4 | ForEach-Object {$a=New-Object Windows.Media.Animation.DoubleAnimation;$a.From=4;$a.To=16-($_%3)*3;$a.Duration=[TimeSpan]::FromMilliseconds(280+$_*87);$a.AutoReverse=$true;$a.RepeatBehavior=[Windows.Media.Animation.RepeatBehavior]::Forever;$c=$a.CreateClock($true);$ui["Bar$_"].ApplyAnimationClock([Windows.FrameworkElement]::HeightProperty,$c);$ui["MiniBar$_"].ApplyAnimationClock([Windows.FrameworkElement]::HeightProperty,$c);$c.Controller.Pause();$script:clocks+=,$c}
$script:playing=$false;$script:connected=$false;$script:track='';$script:coverKey='';$script:optimisticUntil=[datetime]::MinValue;$script:nextMetadata=[datetime]::MinValue;$script:nextClock=[datetime]::MinValue
$script:syncVolume=$false;$script:desktop=$null;$script:nextDesktop=[datetime]::MinValue
function Update-Desktop {
 $script:desktop=[DesktopControls]::Read();$d=$script:desktop;$ui.Volume.IsEnabled=$d.AudioAvailable;$ui.Mute.IsEnabled=$d.AudioAvailable
 if(-not $ui.Volume.IsMouseCaptureWithin){$script:syncVolume=$true;$ui.Volume.Value=$d.Volume;$script:syncVolume=$false}
 $ui.VolumeLabel.Text=if($d.AudioAvailable){[string]$d.Volume+'%'}else{'Non disponibile'};$ui.Mute.Content=if($d.Muted){'Riattiva audio'}else{'Disattiva audio'}
 $ui.PowerLabel.Text=if($d.HasBattery){'Batteria '+$d.Battery+'%'}else{'Alimentazione PC'};$ui.PowerDetail.Text=if($d.HasBattery -and -not $d.Charging){'A batteria'}else{'Collegato alla corrente'}
}
$ui.Volume.Add_ValueChanged({if(-not $script:syncVolume){try{[DesktopControls]::SetVolume([int]$ui.Volume.Value);$ui.VolumeLabel.Text=([string][int]$ui.Volume.Value)+'%'}catch{$ui.VolumeLabel.Text='Non disponibile'}}})
$ui.Mute.Add_Click({try{$d=[DesktopControls]::Read();[DesktopControls]::SetMute(-not $d.Muted);Update-Desktop}catch{$ui.VolumeLabel.Text='Non disponibile'}})
Update-Desktop
function Timer-Display {$ui.Countdown.Text=('{0:00}:{1:00}' -f [math]::Floor($script:remaining/60),([int][math]::Ceiling($script:remaining)%60))}
function Timer-Controls {$ui.Minutes.IsEnabled=-not $script:focusing;$ui.More.IsEnabled=-not $script:focusing;$ui.Less.IsEnabled=-not $script:focusing;foreach($name in @('Preset5','Preset15','Preset25','Preset45')){$ui[$name].IsEnabled=-not $script:focusing}}
function Accept-Minutes {
 $n=0;if(-not [int]::TryParse($ui.Minutes.Text,[ref]$n) -or $n -lt 1 -or $n -gt 1440){$ui.TimerHint.Text='Inserisci da 1 a 1440 minuti';return $false}
 $script:minutes=$n;return $true
}
$ui.Minutes.Add_TextChanged({if(-not $script:focusing -and (Accept-Minutes)){$script:remaining=$script:minutes*60;$ui.Focus.Content='Avvia timer';$ui.TimerHint.Text='Pronto quando vuoi';Timer-Display}})
$ui.Minutes.Add_PreviewTextInput({$_.Handled=$_.Text -match '\D'})
$ui.Less.Add_Click({if(Accept-Minutes){$ui.Minutes.Text=[string][math]::Max(1,$script:minutes-1)}});$ui.More.Add_Click({if(Accept-Minutes){$ui.Minutes.Text=[string][math]::Min(1440,$script:minutes+1)}})
$ui.Focus.Add_Click({
 if($script:focusing){$script:remaining=[math]::Max(0,[math]::Ceiling(($script:deadline-[datetime]::UtcNow).TotalSeconds));$script:focusing=$false;$ui.Focus.Content='Riprendi';$ui.TimerHint.Text='In pausa'}
 elseif(Accept-Minutes){if($script:remaining -le 0){$script:remaining=$script:minutes*60};$script:deadline=[datetime]::UtcNow.AddSeconds($script:remaining);$script:focusing=$true;$ui.Focus.Content='Pausa';$ui.TimerHint.Text='Il timer continua anche nella pillola'}
 Timer-Controls;Timer-Display
})
$ui.Reset.Add_Click({if(Accept-Minutes){$script:remaining=$script:minutes*60;$script:focusing=$false;$ui.Focus.Content='Avvia timer';$ui.TimerHint.Text='Pronto quando vuoi';Timer-Controls;Timer-Display}})
Timer-Display

$ui.Preset5.Add_Click({$ui.Minutes.Text='5'});$ui.Preset15.Add_Click({$ui.Minutes.Text='15'});$ui.Preset25.Add_Click({$ui.Minutes.Text='25'});$ui.Preset45.Add_Click({$ui.Minutes.Text='45'})
$runtime=[MusicRuntime]::new();$script:snapshot=$runtime.Read()
function Playback-State($playing,$connected){
 $ui.Play.IsEnabled=$connected;$ui.Prev.IsEnabled=$connected;$ui.Next.IsEnabled=$connected
 if($playing -ne $script:playing -or $connected -ne $script:connected){$ui.PlaySymbol.Visibility=if($playing){'Collapsed'}else{'Visible'};$ui.PauseSymbol.Visibility=if($playing){'Visible'}else{'Collapsed'};$ui.Play.ToolTip=if($playing){'Metti in pausa'}else{'Riproduci'};Animate $ui.Wave ([Windows.UIElement]::OpacityProperty) $(if($playing){1}else{0.25}) 160;Animate $ui.MiniWave ([Windows.UIElement]::OpacityProperty) $(if($playing){1}else{0.25}) 160;foreach($c in $script:clocks){if($playing){$c.Controller.Resume()}else{$c.Controller.Pause()}}}
 $script:playing=$playing;$script:connected=$connected
}
$ui.Play.Add_Click({if($script:connected){$runtime.Toggle();$script:optimisticUntil=[datetime]::UtcNow.AddMilliseconds(450);Playback-State (-not $script:playing) $true}})
$ui.Prev.Add_Click({$runtime.Previous()});$ui.Next.Add_Click({$runtime.Next()})
$ui.SeekArea.Add_MouseLeftButtonDown({if($script:snapshot.Connected -and $script:snapshot.CanSeek){$fraction=[math]::Max(0,[math]::Min(1,$_.GetPosition($ui.SeekArea).X/$ui.SeekArea.ActualWidth));$runtime.Seek($fraction);$ui.Progress.Value=100*$fraction}})
function Update-Music {
 $script:snapshot=$runtime.Read();$snap=$script:snapshot;if([datetime]::UtcNow -ge $script:optimisticUntil){Playback-State $snap.Playing $snap.Connected}
 if($snap.Connected){
  $ui.Song.Text=$snap.Title;$ui.MiniSong.Text=$snap.Title;$ui.MiniSong.ToolTip=$snap.Title;$ui.Song.ToolTip=$snap.Title;$ui.Artist.Text=$snap.Artist;$source=$snap.Source
  $app=if($source -match 'spotify'){'Spotify'}elseif($source -match 'brave'){'Brave'}elseif($source -match 'chrome'){'Google Chrome'}elseif($source -match 'msedge'){'Microsoft Edge'}elseif($source -match 'firefox'){'Firefox'}elseif($source -match 'vlc'){'VLC'}elseif($source -match 'AppleMusic'){'Apple Music'}else{'Audio del PC'};$ui.AppName.Text='In riproduzione da '+$app
  if($snap.Key -ne $script:track){$script:track=$snap.Key;$ui.Cover.ImageSource=$null;$ui.MiniCover.ImageSource=$null;$script:coverKey=''}
  if($snap.Cover -and $script:coverKey -ne $snap.Key){try{$ms=New-Object IO.MemoryStream(,$snap.Cover);$img=New-Object Windows.Media.Imaging.BitmapImage;$img.BeginInit();$img.CacheOption='OnLoad';$img.StreamSource=$ms;$img.EndInit();$img.Freeze();$ui.Cover.ImageSource=$img;$ui.MiniCover.ImageSource=$img;$ratio=$img.PixelHeight/[double][math]::Max(1,$img.PixelWidth);$ui.CoverShape.Width=[math]::Min(64,64/$ratio);$ui.CoverShape.Height=[math]::Min(64,64*$ratio);$ui.CoverBack.Background=[Windows.Media.Brushes]::Transparent;$ui.MiniShape.Width=30;$ui.MiniShape.Height=30;$ui.MiniBack.Fill=[Windows.Media.Brushes]::Transparent;$ms.Dispose();$script:coverKey=$snap.Key}catch{}}
 }else{$ui.Song.Text='La tua musica';$ui.MiniSong.Text='La tua musica';$ui.Artist.Text='Avvia un brano sul PC';$ui.AppName.Text=if($snap.Error){'Lettore non disponibile'}else{'In attesa'};$ui.Cover.ImageSource=$null;$ui.MiniCover.ImageSource=$null;$script:track='';$script:coverKey=''}
}
function Frame {
 $script:lightX+=($script:mouseX-$script:lightX)*0.18;$script:lightY+=($script:mouseY-$script:lightY)*0.18;$ui.GlowMotion.X=$script:lightX*$w.ActualWidth-115;$ui.GlowMotion.Y=$script:lightY*$w.ActualHeight-75
 $now=[datetime]::UtcNow;if($script:page -eq 2 -and -not $script:compactMode -and $now -ge $script:nextDesktop){Update-Desktop;$script:nextDesktop=$now.AddSeconds(1)};if($now -ge $script:nextMetadata){Update-Music;$script:nextMetadata=$now.AddMilliseconds(120)}
 $snap=$script:snapshot;$pos=$snap.Position;if($snap.Playing){$pos+=[math]::Max(0,($now-$snap.Sampled).TotalSeconds)};$pos=[math]::Max(0,[math]::Min($pos,$snap.Duration));$ui.Progress.Value=if($snap.Duration -gt 0){100*$pos/$snap.Duration}else{0}
 if($now -ge $script:nextClock){$script:nextClock=$now.AddMilliseconds(200);$ui.Elapsed.Text=('{0}:{1:00}' -f [math]::Floor($pos/60),([int]$pos%60));$ui.Duration.Text=('{0}:{1:00}' -f [math]::Floor($snap.Duration/60),([int]$snap.Duration%60))
  if($script:focusing){$script:remaining=[math]::Max(0,[math]::Ceiling(($script:deadline-$now).TotalSeconds));if($script:remaining -le 0){$script:focusing=$false;$ui.Focus.Content='Ricomincia';$ui.TimerHint.Text='Tempo scaduto';Timer-Controls;[System.Media.SystemSounds]::Asterisk.Play()}};Timer-Display
 }
}
Set-Page 0 1 $false;Update-Music
$timer=New-Object Windows.Threading.DispatcherTimer;$timer.Interval=[TimeSpan]::FromMilliseconds(16);$timer.Add_Tick({Frame});$timer.Start()
$w.Add_Closed({$timer.Stop();$runtime.Dispose();if(-not $Check){@{X=$w.Left;Y=$w.Top} | ConvertTo-Json | Set-Content $position -Encoding UTF8;@{Minutes=$script:minutes} | ConvertTo-Json | Set-Content $prefs -Encoding UTF8}})
if($Check){
 $end=[datetime]::UtcNow.AddSeconds(5);while([datetime]::UtcNow -lt $end){$snap=$runtime.Read();if($snap.Cover){break};Start-Sleep -Milliseconds 40};Update-Music;$w.Show();$w.UpdateLayout()
 foreach($expected in 1,2,0){$script:lastWheel=[datetime]::MinValue;$event=[Windows.Input.MouseWheelEventArgs]::new([Windows.Input.Mouse]::PrimaryDevice,[Environment]::TickCount,-120);$event.RoutedEvent=[Windows.Input.Mouse]::PreviewMouseWheelEvent;$w.RaiseEvent($event);if($script:page -ne $expected){throw 'Navigazione rotellina errata'}}
 $ui.Minutes.Text='7';if($script:remaining -ne 420){throw 'Durata timer errata'};$ui.Focus.RaiseEvent([Windows.RoutedEventArgs]::new([Windows.Controls.Button]::ClickEvent));if(-not $script:focusing){throw 'Avvio timer errato'}
 $initialX=$w.Left;$initialY=$w.Top
 foreach($point in @(@(-1400,100),@(2200,150),@(200,-900))){$w.Left=$point[0];$w.Top=$point[1];foreach($page in 0..2){Set-Page $page 1 $false;Set-Compact $true $false;Set-Compact $false $false;if($w.Left -ne $point[0] -or $w.Top -ne $point[1]){throw 'Posizione desktop cambiata durante il ridimensionamento'}}}
 $w.Left=$initialX;$w.Top=$initialY
 foreach($page in 0..2){Set-Page $page 1 $false;Set-Compact $true $false;$w.UpdateLayout();if($ui.MiniSong.Text -ne $ui.Song.Text -or $ui.Expanded.Visibility -ne 'Collapsed' -or -not $ui.MiniWave){throw 'Mini errato'};Set-Compact $false $false;if($script:page -ne $page){throw 'Pagina persa'}}
 if(-not $script:focusing){throw 'Timer interrotto cambiando pagina'};$ui.Reset.RaiseEvent([Windows.RoutedEventArgs]::new([Windows.Controls.Button]::ClickEvent));if($script:focusing -or $script:remaining -ne 420){throw 'Reset timer errato'}
 foreach($view in @('Musica','Timer','Volume','Compatto')){
  if($view -eq 'Compatto'){Set-Compact $true $false}else{Set-Compact $false $false;Set-Page ([array]::IndexOf(@('Musica','Timer','Volume'),$view)) 1 $false};$w.UpdateLayout();Frame
  $width=[int]$w.Width;$height=[int]$w.Height;$bmp=New-Object Windows.Media.Imaging.RenderTargetBitmap($width,$height,96,96,[Windows.Media.PixelFormats]::Pbgra32);$bmp.Render($w)
  foreach($point in @(@(0,0),@(($width-1),0),@(0,($height-1)),@(($width-1),($height-1)))){$pixel=New-Object byte[] 4;$bmp.CopyPixels([Windows.Int32Rect]::new($point[0],$point[1],1,1),$pixel,4,0);if($pixel[3] -ne 0){throw "Bordo esterno opaco: $view"}}
  $enc=New-Object Windows.Media.Imaging.PngBitmapEncoder;$enc.Frames.Add([Windows.Media.Imaging.BitmapFrame]::Create($bmp));$f=[IO.File]::Create((Join-Path $PSScriptRoot ($view+'.png')));$enc.Save($f);$f.Dispose()
 }
 Write-Output ('OK - Musica/Timer/Volume, timer personalizzato e persistente tra schede, mini animato e bordi trasparenti. Copertina: '+[bool]$ui.MiniCover.ImageSource);$w.Close()
}else{$null=$w.ShowDialog()}
