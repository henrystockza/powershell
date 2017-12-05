<# 
.Synopsis
	This Report shows an HTML Percentage table breakdown of how diskspace is used
.DESCRIPTION
   This script goes x levels deep on your file system and sum's the amount of disk space used.
   It shows you the total disk size, total free space and then the amount each folder uses in PERCENTAGE
   as to the total USED space, NOT total disk space.
.Inputs
	-Disk => This controls the disk to check
    -Level Control => This controls the amount of levels deep the scan runs
.Outputs
	This file will generate an output file of ".\TreeSize.html"
.Example
    Treesize "C:"
.Notes
	You will need to change the level conbtrol within the Declaration of variables
	Created by 	: Henry Stock
	Version 	: V3.0.0.0
	Dated		: March 2017
	Authorised	: Henry Stock
	OS			: Windows
	Clients		: All
	PS Version	: All
.Link
	

#>

#Elevate the Script
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; exit }

#Declaration of Variables
$objFormattedDate=get-date -f "dd-MM-yyyy HH:mm:ss"
$objHost=$env:computername
$level = 0
$lvlControl = 3

#Global Variables
$global:objHTML=$null
[int]$global:DiskSize
[int]$global:FreeSpace
[int]$global:PercentUsed
[int]$global:UsedSpace



function getSubfolder
{
    param([string]$objfolder)


    #Set counter to 1st root folder
    $level = $level+1
    
    #try to enter folder
    try 
    {
        $arrayFolderList  = Get-ChildItem -path $objfolder -Directory
    }
    
    Catch 
    { 
        write-erorr "Unable to open folder $objfolder"
    }
    
    Finally 
    {
        
        $global:objHTML+= "<tr> `r`n"
        
        #Get the folder Size
        $Size = get-childitem $objsubfolder.fullname -recurse|  Measure-Object -property Length -Sum 
        [int]$size = $size.sum/ 1mb
        
        #Calculate the Percentage used for Percentage bar
        [int]$Percentage=[math]::round($size/$global:UsedSpace*100,0)

        #format to output table
        $global:objHTML+= "<td>" + $objsubfolder.fullname + "</td> `r`n"
        $global:objHTML+= "<td>" + $size + "MB</td> `r`n"
        $global:objHTML+= "<td><progress value = `"" + $Percentage + "`" MAX=""100""></td> `r`n"
        $global:objHTML+= "</tr> `r`n"


        #Recurse for levels
        Foreach($objsubfolder in $arrayFolderList)
        {
            if ($level -eq $lvlControl){break}    
            getSubfolder $objsubfolder.fullname
    
        }#End Sub Loop
    }# End Finally
  
} #End Funtion






function buildhmtl
{

    #Start of HTML Document format
    $global:objHTML=	"<html> `r`n" 
    $global:objHTML+=	"<head> `r`n"
    $global:objHTML+=	"<Title><h1>" + $objHost + "</h1></Title> `r`n"
    $global:objHTML+=	"<Style>"
    $global:objHTML+=	" table{  border: 1px solid black;}`
			     td {  border-bottom: 1px solid #ddd;text-align: left;font-size:12}`
			     .label {  border-bottom: 1px solid #ddd;text-align: left;font-weight: bold;color:blue;font-size:18}`
			     th {  border-bottom: 1px solid #ddd;text-align: left;font-size:15;} `r`n`
    "
    $global:objHTML+=	"</Style> `r`n"
    $global:objHTML+=	"</head> `r`n"
    $global:objHTML+=	"<body> `r`n"
    $global:objHTML+=	"<h1><b>"+ $objHost+"_"+$objFormattedDate+"</h1></b><th> `r`n"

    ###################################################################################### SECTION::File Size

    #Method


    #Set the Table and first header
    $global:objHTML+=	"<table width=100%> `r`n"
    $global:objHTML+= "<tr> <br> </tr> `r`n" 
    $global:objHTML+= "<tr> `r`n"
    $global:objHTML+= "<th class=""label"" colspan=2> TreeSize  </th> `r`n"
    $global:objHTML+= "<tr></tr>"
    $global:objHTML+= "<td> <progress value = `"" + $PercentUsed + "`" MAX=""100"" </td>"
    $global:objHTML+= "<tr></tr>"
    $global:objHTML+= "<td> "+$percentUsed + "% Used | "+$FreeSpace + "MB </td>" 
    $global:objHTML+= "</tr> `r`n"

    #Set Headers
    $global:objHTML+= "<tr>"
    $global:objHTML+= "<th><b> FilePath  </b></th> `r`n"
    $global:objHTML+= "<th><b> Size In MB  </b></th> `r`n"
    $global:objHTML+= "</tr> `r`n"

    getSubfolder "$Disk\"

}






function TreeSize
{
    param([string]$Disk)

    #Calculate the Disk Percentage and Size
    $DiskInfo = gwmi -class Win32_LogicalDisk | where {$_.deviceid -like $Disk}
    [int]$global:DiskSize = $DiskInfo.Size / 1mb
    [int]$global:FreeSpace = $DiskInfo.FreeSpace / 1mb
    [int]$global:UsedSpace = $global:DiskSize - $global:FreeSpace
    [int]$global:PercentUsed= [math]::round($FreeSpace/$DiskSize*100,0)


    buildhmtl

}



TreeSize "C:"
#output to file
$global:objHTML | out-file  C:\Automation\Treesize.html


