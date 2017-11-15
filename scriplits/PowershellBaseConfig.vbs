 Set oShell = CreateObject("Shell.Application")  
 oShell.ShellExecute "%SystemRoot%\syswow64\WindowsPowerShell\v1.0\powershell.exe", "set-executionpolicy bypass", "", "runas", 1 
 oShell.ShellExecute "%%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe", "set-executionpolicy bypass", "", "runas", 1 
 oShell.ShellExecute "%%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe", "winrm quickconfig /force", "", "runas", 1 
  oShell.ShellExecute "%%SystemRoot%\system32\WindowsPowerShell\v1.0\powershell.exe", "Enable-PSRemoting -force", "", "runas", 1 
 
 
''Syntax
''     .ShellExecute "application", "parameters", "dir", "verb", window
''
''     .ShellExecute 'some program.exe', '"some parameters with spaces"', , "runas", 1
''Key
''   application   The file to execute (required)
''  parameters    Arguments for the executable
''  dir           Working directory
''   verb          The operation to execute (runas/open/edit/print)
''   window        View mode application window (normal=1, hide=0, 2=Min, 3=max, 4=restore, 5=current, 7=min/inactive, 10=default)