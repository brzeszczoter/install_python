<#
 # get-python.ps1
 .SYNOPSIS
  Use function to get Python msi files from internet sources
 .EXAMPLE
  get-pythonmsi 
 .EXAMPLE
  # Main
  get-pythonmsi -verbose
#>
function get-pythonmsi
{
[cmdletbinding(SupportsShouldProcess=$true)]

param( 
    $python = @{"url" = "http://python.org/ftp/python/2.7.3/python-2.7.3.msi"; 
               "out_name" = "python-2.7.3.msi";
	           "run" = "msiexec /i python-2.7.3.msi"},
    $distribute = @{"url"="http://python-distribute.org/distribute_setup.py"; 
               "out_name" = "distribute_setup.py";
	           "run" = "cmd /c c:\python27\python.exe distribute_setup.py"},
    $pip = @{"url"="https://raw.github.com/pypa/pip/master/contrib/get-pip.py"; 
             "out_name"= "get-pip.py";
	         "run" = "cmd /c c:\python27\python.exe get-pip.py"}
             )

Begin{
   # Enter the names of parameters into array
   $progs = @($python, $distribute, $pip);}


Process{
    # Download files to temp
    cd $env:temp;
    
    # Use Dot Net client to download files
    $netclient = new-object net.webclient;
    
    # Get items in hash
    foreach ($item in $progs)
    {  
	try {
	$msg = -join ("Downloading file ", $item['out_name'], " to ", $env:temp)
	write-verbose -message $msg
        #$netclient.DownloadFile($item['url'], $env:temp + "\" + $item['out_name'])
	$itempath = -join ($env:temp, "\", $item['out_name'])
	if (test-path -path $itempath) {"File has arrived"}
	    }
	catch { "An error occurred in the process section of get-pythonmsi"}
    } 
       }
 End { "Function has get-pythonmsi has reached the end block"}
}