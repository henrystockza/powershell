#Get-Programs
Gets all installed programs from windows uninstall registry key HKlm:\Software\Microsoft\Windows\CurrentVersion\Uninstall
Prints to screen [-screen] or exports to [-csv] [-xml] [-json]

#Example

x


#Inputs
    -s -screen  => Print to screen [switch]
	-p -path 	=> Full name and path to export file to excluding extension
    -c -csv     => Export to csv [switch]
    -x -xml     => Export to XML [switch]
    -j -json    => Export to json [switch]
#Example
	get-programs -s
    get-programs -screen
    get-programs -s -path c:\temp\installedprograms.csv -c -j -x
    get-programs -screen -path c:\temp\installedprograms.csv -csv -json -xml
	remove-olditems -path c:\temp\ -days 30 -recurse -log


#MIT License

Copyright (c) 2017 HenryStockZa

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

	