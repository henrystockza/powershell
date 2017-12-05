
function getErrorReporting()
{
    $errorReporting1 = 'Not Configured'
    $errorReporting2 = 'Not Configured'
    $errorReporting = "Not Configured"
    if(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting")
    {
        if((get-item "HKLM:\SOFTWARE\Policies\Microsoft\Windows").GetValue("Windows Error Reporting") -contains "Disabled")
        {
            $errorReporting1 = "Disabled"
        }
        else
        {
            $errorReporting1 = "Enabled"
        }
    }
    else
    {
        #Ignore
    }


    if ((get-service wersvc).StartType -like "Disabl*")
    {
        $errorReporting2 = "Disabled"
    }
    else
    {
        $errorReporting2 = "Enabled"
    }


    if($errorReporting1 -eq "Enabled" -or $errorReporting2 -eq "Enabled")
    {
        $errorReporting = "Enabled"
    }
    elseif($errorReporting1 -eq "Disabled" -or $errorReporting2 -eq "Disabled")
    {
        $errorReporting = "Disabled"
    }
    else
    {
        #Ignore
    }

    return $errorReporting
}

$errorReporting = getErrorReporting