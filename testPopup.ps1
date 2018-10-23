Add-Type -AssemblyName PresentationCore,PresentationFramework
$ButtonType = [System.Windows.MessageBoxButton]::YesNoCancel
$MessageIcon = [System.Windows.MessageBoxImage]::Information
If(!$MessageBody){
  $MessageBody = "DKBInnovative has determined your computer needs to be restarted to complete critical patch installs. Can we reboot your computer now?"
}
If(!$MessageTitle){
  $MessageTitle = "Message From DKBInnovative"
}

$Result = [System.Windows.MessageBox]::Show($MessageBody,$MessageTitle,$ButtonType,$MessageIcon)

Write-Output "$Result"


<#

powershell.exe -command "& {(new-object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dkbrookie/Testing/master/popupController.ps1') | iex}"

#>
