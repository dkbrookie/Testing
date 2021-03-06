## Clear out all variables / hash tables before starting the script
Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear(); Clear-Host

#region setVars
$MessageTitle = "title message here"
$MessageBody = "body of the message here"
$popupURL = 'https://raw.githubusercontent.com/dkbrookie/Testing/master/testPopup.ps1'
#endregion setVars

## Get the list of active users so we can run the popup on the active console numbers
#region getUsers
$userHash = @()
ForEach($ServerLine in @(query user) -split "\n") {
    $Report = "" | Select-Object UserName, Session, ID, State, IdleTime, LogonTime
    $Parsed_Server = $ServerLine -split '\s+'
    If($Parsed_Server -like "USERNAME*"){
    Continue
    }
    $Report.UserName =  $Parsed_Server[1]
    $Report.Session = $Parsed_Server[2]
    $Report.ID = $Parsed_Server[3]
    $Report.State = $Parsed_Server[4]
    $Report.IdleTime = $Parsed_Server[5]
    $Report.LogonTime = $Parsed_Server[6]+" " +$Parsed_Server[7]+" "+$Parsed_Server[8]

    If($Parsed_Server[3] -eq "Disc"){
        $Report.Session = "None"
        $Report.ID = $Parsed_Server[2]
        $Report.State = $Parsed_Server[3]
        $Report.IdleTime = $Parsed_Server[4]
        $Report.LogonTime = $Parsed_Server[5]+" " +$Parsed_Server[6]+" "+$Parsed_Server[7]
    }

    If($Parsed_Server -like ">*"){
        $Parsed_Server=$Parsed_Server.Replace(">","")
        $Report.UserName =  $Parsed_Server[0]
        $Report.Session = $Parsed_Server[1]
        $Report.ID = $Parsed_Server[2]
        $Report.State = $Parsed_Server[3]
        $Report.IdleTime = $Parsed_Server[4]
        $Report.LogonTime = $Parsed_Server[5]+" " +$Parsed_Server[6]+" "+$Parsed_Server[7]
    }
    $HaSH+=$Report
}
#endregion getUsers

#region popup
$homeDir = "$env:windir\LTSvc"
$vbsFile = "command = ""powershell.exe -NoLogo -WindowStyle Hidden -Command `$MessageBody = '$MessageBody' ; `$MessageTitle = '$MessageTitle' ; (new-object Net.WebClient).DownloadString('https://raw.githubusercontent.com/dkbrookie/Testing/master/testPopup.ps1') | iex | Out-File $homeDir\'popAnswer.txt'""

set shell = CreateObject(""WScript.Shell"")

shell.Run command,0,true"
$vbsFile | Out-File "$homeDir\popCall.vbs"

## Run the popup command on all active sessions
ForEach($ID in $Hash.ID){
    &c:\psexec.exe -accepteula -s -i $ID -nobanner wscript $homeDir\popCall.vbs --quiet --no-verbose >$null 2>&1
}

$answer = Get-Content -Path "$homeDir\popAnswer.txt"
$answer
#endregion popup
