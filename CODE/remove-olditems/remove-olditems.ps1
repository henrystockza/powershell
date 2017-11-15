<# 
.Synopsis
	Removes requested items not accesed within this time period
.DESCRIPTION
   This Script will scan the requested directory and remove all items not accesed within the given time period
.Parameter
.Inputs
	-p -path 	=> The folder path you wish to scan
	-d -days 	=> Will delete any items not accesed within this timeframe
	-r -recurse => Delete recursively [switch]
	-l -log		=> Will log to the given filename [switch]
.Outputs
	No output is given on this script
.Example
	remove-olditems -p c:\temp\ -d 30
    remove-olditems -p c:\temp\ -d 30 -r -l
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
		Mandatory=$true,
		Position=0,
		ValueFromPipelineByPropertyName=$true,
		ValueFromPipeline=$true,
		HelpMessage="Enter the path you wish to scan for old file")
	]
	[ValidateNotNullOrEmpty()]
	[alias("p")]
	[String[]]
	$path,
	
	[parameter(
		Mandatory=$true,
		Position=1,
		ValueFromPipelineByPropertyName=$true,
		ValueFromPipeline=$true,
		HelpMessage="Enter the max amount of days before deletion [last accessed]")
	]
	[ValidateNotNullOrEmpty()]
	[alias("d")]
	[String[]]
	$days,
	
	[switch]$recurse,
	[switch]$r,
	[switch]$log,
	[switch]$l
)
	
$objdeldate = (get-date).AddDays(-[convert]::ToInt32($days,10))
write-host $objdeldate
$fdatename = Get-Date -Format "ddMMyy HHmmSS "
$outname = "c:\temp\" + $fdatename + "RemoveOldItems_LOG.log"

if($recurse -eq $True -or $r -eq $True)
{
    $arrFiles = get-childitem -Path $path -Recurse
}
else
{
    $arrFiles = get-childitem -Path $path
}

foreach($item in $arrFiles)
{
    $fullpath = $item.fullname
    $DateLA = (get-item -path $fullpath).LastAccessTime
    if( $DateLA -le $objdeldate)
    {
        if($l -eq $True -or $log -eq $True)
        {
            "$fullpath, $dateLA, DELETED" | Out-File $outname -Append
        }
        else {}

        Remove-Item $fullpath -recurse -Force
    }
    else {}
}