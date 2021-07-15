Param( [switch]$interactive )

$settingFile = "./settings"

# OS detection{{{
If( ${env:OS} -eq "" )
{
  ${env:OS} = uname -s
}

Write-Host "detected OS: ${env:OS}"
# end OS detection
#}}}
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
        "y"     { $ifInstall = 1; Break       }
        "n"     { $ifInstall = 0; Break       }
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
  If( "${ifInstall}" -eq "1" )
  {
    Write-Host "install ${sourceFile}"
    Copy-Item "${sourceFile}" "${TargetFile}"
  }
  # end install file}}}
}
# end function definition
#}}}
# setup default path{{{
If( "${muttSettingsTarget}" -eq "" )
{
  $muttSettingsTarget = $(./defaultPath.ps1 mutt ${env:OS})
}
If( "${gitSettingsTarget}" -eq "" )
{
  $gitSettingsTarget = $(./defaultPath.ps1 git ${env:OS})
}
If( "${topSettingsTarget}" -eq "" )
{
  $topSettingsTarget = $(./defaultPath.ps1 top ${env:OS})
}
If( "${tmuxSettingsTarget}" -eq "" )
{
  $tmuxSettingsTarget = $(./defaultPath.ps1 tmux ${env:OS})
}
If( "${screenSettingsTarget}" -eq "" )
{
  $screenSettingsTarget = $(./defaultPath.ps1 screen ${env:OS})
}
If( "${mpvSettingsTarget}" -eq "" )
{
  $mpvSettingsTarget = "$(./defaultPath.ps1 mpv ${env:OS})/mpv.conf"
}
If( "${starshipSettingsTarget}" -eq "" )
{
  $starshipSettingsTarget = $(./defaultPath.ps1 starship ${env:OS})
}
If( "${efmLanguageServerSettingsTarget}" -eq "" )
{
  $efmLanguageServerSettingsTarget = $(./defaultPath.ps1 efmLanguageServer ${env:OS})
}
If( "${mpsytPlaylistTargetDir}" -eq "" )
{
  $mpsytPlaylistTargetDir = $(./defaultPath.ps1 mpsyt ${env:OS})
}
# end setup default path
#}}}
# install setting files{{{
installSettings ${muttSettingsSource}               ${muttSettingsTarget}               ${installMuttSettings}
installSettings ${gitSettingsSource}                ${gitSettingsTarget}                ${installGitSettings}
installSettings ${topSettingsSource}                ${topSettingsTarget}                ${installTopSettings}
installSettings ${tmuxSettingsSource}               ${tmuxSettingsTarget}               ${installTmuxSettings}
installSettings ${screenSettingsSource}             ${screenSettingsTarget}             ${installScreenSettings}
installSettings ${mpvSettingsSource}                ${mpvSettingsTarget}                ${installMpvSettings}
installSettings ${starshipSettingsSource}           ${starshipSettingsTarget}           ${installStarshipSettings}
installSettings ${efmLanguageServerSettingsSource}  ${efmLanguageServerSettingsTarget}  ${installEfmLanguageServerSettings}

$mpsytPlaylistSources = $mpsytPlaylistSources -replace '"',''

ForEach( $file in -split ${mpsytPlaylistSources} )
{
  $source = "${mpsytPlaylistSourceDir}/${file}"
  $target = "${mpsytPlaylistTargetDir}/${file}"

  installSettings ${source} ${target} ${installMpsytPlaylistSettings}
}
# end install setting files}}}
# vim: foldmethod=marker foldmarker={{{,}}}
