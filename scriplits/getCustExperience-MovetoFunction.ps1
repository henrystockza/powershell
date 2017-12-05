
function getCustExperience()
{
    $custexp = "Not Configured"
    if(Test-Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows\Windows Error Reporting")
    {
        if((get-item "HKLM:\Software\Microsoft\SQMClient\Windows\").GetValue("CEIPEnable") -contains "Disabled")
        {
            $custexp = "Disabled"
        }
        else
        {
            $custexp = "Enabled"
        }
    }
    else
    {
        #Ignore
    }

    return $custexp
}

$custexp = getCustExperience