#!/bin/sh

# OS detection{{{
if [ -z ${OS} ]; then
  OS=$(uname -s)
fi

echo "detected OS: ${OS}"
# end OS detection
#}}}
. ./settings

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
rm ${muttSettingsTarget}
rm ${gitSettingsTarget}
rm ${topSettingsTarget}
rm ${tmuxSettingsTarget}
rm ${screenSettingsTarget}
rm ${mpvSettingsTarget}

for file in ${mpsytPlaylistSources}; do
{
  source="${mpsytPlaylistSourceDir}/${file}"
  target="${mpsytPlaylistTargetDir}/${file}"

  rm ${target}
}
done
# end install setting files}}}
# vim: foldmethod=marker foldmarker={{{,}}}
