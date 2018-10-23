Add-Type -AssemblyName PresentationCore,PresentationFramework
$ButtonType = [System.Windows.MessageBoxButton]::YesNoCancel
$MessageIcon = [System.Windows.MessageBoxImage]::Information
$MessageBody = "DKBInnovative has determined your computer needs to be restarted to complete critical patch installs. Can we reboot your computer now?"
$MessageTitle = "Message From DKBInnovative"

$Result = [System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)

Write-Output "$Result"


<#
"C:\Windows\LTSvc\psIcon.lnk" -command "& {(new-object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dkbrookie/Testing/master/testPopup.ps1') | iex}"
#>
