function getSecurityOptions($securityinfo)
{
    foreach($line in $securityinfo)
    {
        $line = $line.trim()
        $missme = $False

        #1 Grab segment
        if($line -like "*Security Options*")
        {
            $grabme = $True
            $previousline = $line.trim()
            $missme = $True
        }
        elseif($line -like "Event Log Settings")
        {
            $grabme = $False
        }

        if($grabme -eq $True)
        {
            #2 Skip GPO line and ---
            if($line -like "GPO:*" -or $line -like "*---*")
            {
                $missme = $True
            }
            else
            {
                #pass
            }

            #3 Set Policy line 
            if($line.IndexOf("Policy:") -ge 0)
            {
                $line = $line.Replace("Policy:","")
                $line = $line.trim()
                $previousline = $line
                $missme = $True

            }
            else
            {
                #pass
            }

            #4 Mark end of segment
            if($line -eq "")
            {
                $NextItem = $True
            }
            else
            {
                $NextItem = $False
            }

            #Grab line
            if($missme -eq $False -and $NextItem -eq $False)
            {
                if($line.IndexOf("Computer Setting:") -ge 0)
                {
                    $line = $line.replace("Computer Setting:","")
                }
                $line = $line.trim()
                $Info = $Info + "$previousline`:$line `n"
            } 
            else
            {
                #Pass
            }

        }

    }
    return $Info
}


$SecurityOptions = getSecurityOptions($securityinfo)
$SecurityOptions