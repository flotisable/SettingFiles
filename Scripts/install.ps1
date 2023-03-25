Param( [switch]$interactive )

$settingFile = "./settings.toml"

$scriptDir = "$(Split-Path $PSCommandPath )"

. ${scriptDir}/readSettings.ps1 $settingFile

# function definition{{{
Function installSettings
{
  # function arguments{{{
  $sourceFile = $args[0]
  $targetFile = $args[1]
  # end function arguments
  #}}}
  # interactive mode{{{
  If( ${interactive} )
  {
    Write-Host "do you want to install ${sourceFile} [y/n]? "

    While( $value = Read-Host )
    {
      Switch( ${value} )
      {
        "y"     { $ifInstall = $True;   Break }
        "n"     { $ifInstall = $False;  Break }
        Default { Write-Host "invalid input!" }
      }
      # not use -in because older powershell does not support this
      If( $value -eq "y" -or $value -eq "n" )
      {
        Break
      }
    }
  }
  # end interactive mode
  #}}}
  # install file{{{
  If( New-Item -Type Directory -ErrorAction SilentlyContinue $dir)
  {
    Write-Host "create directory" $dir
  }
  Write-Host "install ${sourceFile}"
  Copy-Item "${sourceFile}" "${targetFile}"
  # end install file}}}
}
# end function definition
#}}}
# install setting files{{{
$root           = Invoke-Expression "Write-Output $($settings['dir']['root'])"
$rcRoot         = ( Get-Item ${scriptDir}/../Settings/$os ).FullName
$rcRootPattern  = "$( $rcRoot -replace '\\', '\\' )\\"

ForEach( $file in ( Get-ChildItem -Recurse -FollowSymlink -File $rcRoot ).FullName )
{
  $file       = $file -replace $rcRootPattern, ""
  $sourceFile = "$rcRoot/$file"
  $targetFile = "$root/$file"
  $dir        = $(Split-Path -Parent $targetFile)

  installSettings $sourceFile $targetFile
}
# end install setting files}}}
# vim: foldmethod=marker foldmarker={{{,}}}
