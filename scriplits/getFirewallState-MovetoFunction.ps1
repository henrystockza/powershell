
function getFireWallState()
{
    $fwsettings = cmd /c "Netsh Advfirewall show allprofiles"
    $fwinfoline = ""
    foreach($line in $fwsettings)
    {
        if($line -match "State")
        {
            $profile =  $previousline
            $state =  $line.replace(" ",'').replace("State",'')
            $fwinfoline = $fwinfoline + "$profile-$state "
        }
        elseif($line -match '-------')
        {
            #Ignore
        }
        elseif($line -match "Domain Profile Settings:" -or $line -match "Private Profile Settings:" -or $line -match "Public Profile Settings:")
        {
            $previousline = $line.replace(" Profile Settings:",'').trim()
        }
        else
        {
            #Ignore
        }
    
    }

    return $fwinfoline
}

$fwstate  = getFirewallstate
