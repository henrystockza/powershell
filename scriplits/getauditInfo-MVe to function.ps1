function getAuditPolicy($securityinfo)
{
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

        if($line -like "Audit*")
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
            if($line -notlike "*---*")
            {
                $line = $line.replace("Computer Setting:","")
                $line = $line.trim()
                $Info = $Info + "$previousline`:$line `n"
            }
            $grabnextline = $False
        }
        else
        {
            #pass
        }

    }

    return $Info


}
$AuditInfo = getAuditPolicy($securityinfo)
$AuditInfo