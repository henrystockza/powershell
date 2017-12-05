$securityinfo = cmd /c "gpresult /r /v /SCOPE COMPUTER"

function getPasswordSettings($securityinfo)
{
    $listofIfoToGather = ("LockoutDuration", ",MaximumPasswordAge", "MinimumPasswordAge", "ResetLockoutCount", "LockoutBadCount", "PasswordHistorySize", "MinimumPasswordLength", "Store passwords using reversible encryption")
    
    foreach($line in $securityinfo)
    {
        $line = $line.trim()
        $missme = $False
        if($line.IndexOf("Policy:") -ge 0)
        {
            $line = $line.Replace("Policy:","")
            $line = $line.trim()
        }
        else
        {
            #pass
        }

        if($line -in $listofIfoToGather)
        {
            $previousline = $line.trim()
            $grabnextline = $True
            $missme = $True
        }
        else
        {
            #pass
        }

        if($grabnextline -eq $True -and $missme -eq $False)
        {
            $line = $line.replace("Computer Setting:","")
            $line = $line.trim()
            $Info = $Info + "$previousline`:$line `n"
            $grabnextline = $False
        }
        else
        {
            #pass
        }

    }

    return $Info

}
$PasswordInfo = getPasswordSettings($securityinfo)
$PasswordInfo