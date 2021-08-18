Param( [switch]$interactive )

$settingFile = "./settings.toml"

. ./readSettings.ps1 $settingFile

# function definition{{{
Function installSettings
{
  # function arguments{{{
  $sourceFile = $args[0]
  $targetFile = $args[1]
  $ifInstall  = $args[2]
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
        "n"     { $ifInstall = $FalsE;  Break }
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
  If( ${ifInstall} )
  {
    Write-Host "install ${sourceFile}"
    Copy-Item "${sourceFile}" "${targetFile}"
  }
  # end install file}}}
}
# end function definition
#}}}
# install setting files{{{
ForEach( $target in $settings['target'].keys )
{
  $targetFile = Invoke-Expression "Write-Output $($settings['target'][$target])"
  $sourceFile = Invoke-Expression "Write-Output $($settings['source'][$target])"

  If( $target -eq 'playlistDir' )
  {
    If( Test-Path $targetFile -PathType Container )
    {
      ForEach( $playlist in $settings['source']['playlist'] )
      {
        installSettings $sourceFile/$playlist $targetFile/$playlist $settings['install'][$target]
      }
    }
    Continue
  }
  installSettings $sourceFile $targetFile $settings['install'][$target]
}
# end install setting files}}}
# vim: foldmethod=marker foldmarker={{{,}}}
