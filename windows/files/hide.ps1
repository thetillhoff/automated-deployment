# add hidden attribute to all files and folders in the current directory which names start with a dot.

Get-ChildItem . | ForEach-Object {
  if ( $_ -is [System.IO.DirectoryInfo]) { # if element is directory
    if ( $_.BaseName.length -gt 1 -and $_.BaseName.Substring(0,1) -eq '.' ) {
      $_.Attributes="Hidden";
      Write-Output "folder $($_.BaseName) is now hidden";
    }
  } else { # else element is file
    if ( $_.BaseName.Length -eq 0 -and $_.Extension.Length -gt 1 ) {
      $_.Attributes="Hidden";
      Write-Output "file $($_.Extension) is now hidden";
    }
  }
}
