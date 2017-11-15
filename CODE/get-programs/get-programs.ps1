<# 
.Synopsis
	Gets all installed programs from windows uninstall registry key
.DESCRIPTION
   This Script scans and returns all items under the registry key HKlm:\Software\Microsoft\Windows\CurrentVersion\Uninstall
.Parameter
.Inputs
    -s -screen  => Print to screen [switch]
	-p -path 	=> Full name and path to export file to excluding extension
    -c -csv     => Export to csv [switch]
    -x -xml     => Export to XML [switch]
    -j -json    => Export to json [switch]
.Outputs
	No output is given on this script
.Example
	get-programs -s
    get-programs -screen
    get-programs -s -path c:\temp\installedprograms.csv -c -j -x
    get-programs -screen -path c:\temp\installedprograms.csv -csv -json -xml
	remove-olditems -path c:\temp\ -days 30 -recurse -log
.Notes
	Created by 	: Henry Stock
	Version 	: V1.0.0.0
	Authorised	: Henry Stock
	OS			: Windows
	PS Version	: All
.Link
	https://github.com/henrystockza
#>


Param([
	parameter(
		Mandatory=$false,
		Position=0,
		ValueFromPipelineByPropertyName=$true,
		ValueFromPipeline=$true,
		HelpMessage="Enter the path you wish to scan for old file")
	]
	[ValidateNotNullOrEmpty()]
	[alias("p")]
	[String[]]
	$path,

	[switch]$s,
    [switch]$screen,
    [switch]$c,
    [switch]$csv,
    [switch]$x,
    [switch]$xml,
    [switch]$j,
    [switch]$json
)

if($path -eq $null)
{
    $fdatename = Get-Date -Format "ddMMyy HHmmSS "
    $filename = "c:\temp\" + $fdatename + "Programs"
}
else
{
    $filename = $path
}

$programlist = @()
foreach($item in (get-childitem HKlm:\Software\Microsoft\Windows\CurrentVersion\Uninstall))
{
    $name = $item.GetValue("Displayname")
    $version = $item.GetValue("DisplayVersion")
    $publisher = $item.GetValue("Publisher")
    $UninstallString = $item.GetValue("UninstallString")
    $URLInfoAbout = $item.GetValue("URLInfoAbout")
    $InstallDate = $item.GetValue("InstallDate")

    if($name -eq '' -or $name -eq $null){$name = "null"}
    if($version -eq '' -or $version -eq $null){$version = "null"}
    if($publisher -eq '' -or $publisher -eq $null){$publisher = "null"}
    if($UninstallString -eq '' -or $UninstallString -eq $null){$UninstallString = "null"}
    if($URLInfoAbout -eq '' -or $URLInfoAbout -eq $null){$URLInfoAbout = "null"}
    if($InstallDate -eq '' -or $InstallDate -eq $null){$InstallDate = "null"}

    $singlelist = ,($name, $version, $publisher, $UninstallString, $URLInfoAbout, $InstallDate)
    $programlist += $singlelist
}

#Print to screen
if($s -eq $True -or $screen -eq $True)
{
    write-host "Name, Version, Publisher, UninstallString, UrlInfoAbout, InstallDate"
    foreach($item in $programlist)
    {
        write-host $item[0] + "," + $item[1] + "," + $item[2] + "," + $item[3] + "," + $item[4] + "," + $item[5]
    }
}


#Export CSV
if($c -eq $True -or $csv -eq $True -and $filename -ne $null)
{
    $fnc = [string]$filename + ".csv"
    $iCSV = "Name, Version, Publisher, UninstallString, UrlInfoAbout, InstallDate `n" 
    foreach($item in $programlist)
    {
        $iCSV += $item[0] + "," + $item[1] + "," + $item[2] + "," + $item[3] + "," + $item[4] + "," + $item[5] + " `n" 
    }
    $iCSV | out-file $fnc
}


#Export xml
if($x -eq $True -or $xml -eq $True -and $filename -ne $null)
{
    $fnx = [string]$filename + ".xml"
    $iXML = "<payload>`n"
    foreach($item in $programlist)
    {
        $iXML += "`t<program>`n"
        $iXML += "`t`t<Name>" + $item[0] + "</Name>`n"
        $iXML += "`t`t<Version>" + $item[1] + "</Version>`n"
        $iXML += "`t`t<Publisher>" + $item[2] + "</Publisher>`n"
        $iXML += "`t`t<UninstallString>" + $item[3] + "</UninstallString>`n"
        $iXML += "`t`t<UrlInfoAbout>" + $item[4] + "</UrlInfoAbout>`n"
        $iXML += "`t`t<InstallDate>" + $item[5] + "</InstallDate>`n"
        $iXML += "`t</program>`n"
    }
    $iXML += "</payload>`n"
    $iXML | out-file $fnx
}

#Export json
if($j -eq $True -or $json -eq $True -and $filename -ne $null)
{
    $fnj = [string]$filename + ".json"
    $iJSON = "{ `n "
    $iJSON += " `t `"payload`": { `n "
    $iJSON += "`t`t `"program`": [ `n "
    $counter = 0
    foreach($item in $programlist)
    {
        $iJSON += " `t`t`t{  `n "
        $iJSON += " `t`t`t `"NAME`": `"" + $item[0] + " `", `n "
        $iJSON += " `t`t`t `"Version`" :`"" + $item[1] + " `", `n "
        $iJSON += " `t`t`t `"Publisher`":`"" + $item[2] + " `", `n "
        $iJSON += " `t`t`t `"UninstallString`": `"" + $item[3].replace("\","\\").replace('"','') + " `", `n "
        $iJSON += " `t`t`t `"UrlInfoAbout`": `"" + $item[4] + " `", `n "
        $iJSON += " `t`t`t `"InstallDate`": `"" + $item[5] + " `" `n "
        $counter = $counter + 1
        if($counter -le $programlist.Count-1)
        {
            $iJSON += "`t`t`t},`n"
        }
        else
        {
        $iJSON += "`t`t`t}`n"
        }
    }
    $iJSON += "`t`t ] `n "
    $iJSON += " `t } `n "
    $iJSON += "} `n "
    $iJSON | out-file $fnj
}