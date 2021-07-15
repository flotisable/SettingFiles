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
Remove-Item ${muttSettingsTarget}
Remove-Item ${gitSettingsTarget}
Remove-Item ${topSettingsTarget}
Remove-Item ${tmuxSettingsTarget}
Remove-Item ${screenSettingsTarget}
Remove-Item ${mpvSettingsTarget}
Remove-Item ${starshipSettingsTarget}
Remove-Item ${efmLanguageServerSettingsTarget}

$mpsytPlaylistSources = $mpsytPlaylistSources -replace '"',''

ForEach( $file in -split ${mpsytPlaylistSources} )
{
  $source = "${mpsytPlaylistSourceDir}/${file}"
  $target = "${mpsytPlaylistTargetDir}/${file}"

  Remove-Item ${target}
}
# end install setting files}}}
# vim: foldmethod=marker foldmarker={{{,}}}
