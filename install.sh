#!/bin/sh

# process arguments{{{
if [ "$1" = "--interactive" -o "$1" = "-i" ]; then
  ifInterActive=1
else
  ifInterActive=0
fi
# end process arguments
#}}}
# OS detection{{{
if [ -z ${OS} ]; then
  OS=$(uname -s)
fi

echo "detected OS: ${OS}"
# end OS detection
#}}}
. ./settings

# function definition{{{
installSettings()
{
  # function arguments{{{
  sourceFile=$1
  TargetFile=$2
  ifInstall=$3
  # end function arguments
#}}}
  # interactive mode{{{
  if [ "${ifInterActive}" = "1" ]; then
  {
    echo "do you want to install ${sourceFile} [y/n]? "

    while read value; do
    {
      case ${value} in

        "y" ) ifInstall=1; break;;
        "n" ) ifInstall=0; break;;
        *   ) echo "invalid input!";;

      esac
    }
    done
  }
  fi
  # end interactive mode
#}}}
  # install file{{{
  if [ "${ifInstall}" = "1" ]; then
    echo "install ${sourceFile}"
    cp "${sourceFile}" "${TargetFile}"
  fi
  # end install file}}}
}
# end function definition
#}}}
# setup default path{{{
if [ -z ${muttSettingsTarget} ]; then
  muttSettingsTarget="$(./defaultPath.sh mutt ${OS})"
fi
if [ -z ${gitSettingsTarget} ]; then
  gitSettingsTarget="$(./defaultPath.sh git ${OS})"
fi
if [ -z ${topSettingsTarget} ]; then
  topSettingsTarget="$(./defaultPath.sh top ${OS})"
fi
if [ -z ${tmuxSettingsTarget} ]; then
  tmuxSettingsTarget="$(./defaultPath.sh tmux ${OS})"
fi
if [ -z ${screenSettingsTarget} ]; then
  screenSettingsTarget="$(./defaultPath.sh screen ${OS})"
fi
if [ -z ${mpvSettingsTarget} ]; then
  mpvSettingsTarget="$(./defaultPath.sh mpv ${OS})/mpv.conf"
fi
if [ -z ${mpsytPlaylistTargetDir} ]; then
  mpsytPlaylistTargetDir="$(./defaultPath.sh mpsyt ${OS})"
fi
# end setup default path
#}}}
# install setting files{{{
installSettings ${muttSettingsSource}   ${muttSettingsTarget}   ${installMuttSettings}
installSettings ${gitSettingsSource}    ${gitSettingsTarget}    ${installGitSettings}
installSettings ${topSettingsSource}    ${topSettingsTarget}    ${installTopSettings}
installSettings ${tmuxSettingsSource}   ${tmuxSettingsTarget}   ${installTmuxSettings}
installSettings ${screenSettingsSource} ${screenSettingsTarget} ${installScreenSettings}
installSettings ${mpvSettingsSource}    ${mpvSettingsTarget}    ${installMpvSettings}

for file in ${mpsytPlaylistSources}; do
{
  source="${mpsytPlaylistSourceDir}/${file}"
  target="${mpsytPlaylistTargetDir}/${file}"

  installSettings ${source} ${target} ${installMpsytPlaylistSettings}
}
done
# end install setting files}}}
# vim: foldmethod=marker foldmarker={{{,}}}
