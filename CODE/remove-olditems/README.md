#Remove-OldItems
Removed items in [-path] [-recurse] older than [-days] last accessed
[-log] Logs output to the [c:\temp\ddMMyy hhmmss olditems_log.log]

#Example

x



#Inputs
	-p -path 	=> The folder path you wish to scan
	-d -days 	=> Will delete any items not accesed within this timeframe
	-r -recurse => Delete recursively [switch]
	-l -log		=> Will log to the given filename [switch]

#Example
	remove-olditems -p c:\temp\ -d 30
    remove-olditems -p c:\temp\ -d 30 -r -l
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

	