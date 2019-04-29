OS ?= $(shell uname -s)

mpsytPlaylistDir := MpsytPlaylist

muttSettingsSource   := .muttrc
gitSettingsSource    := .gitconfig
topSettingsSource    := .toprc
tmuxSettingsSource   := .tmux.conf
mpvSettingsSource    := mpv.conf
mpsytPlaylistSources := favorite.m3u

mpsytPlaylistSourcesFull := $(addprefix ${mpsytPlaylistDir}/,${mpsytPlaylistSources})

muttSettingsTarget   := "${HOME}"/.muttrc
gitSettingsTarget    := "${HOME}"/.gitconfig
topSettingsTarget    := "${HOME}"/.toprc
tmuxSettingsTarget   := "${HOME}"/.tmux.conf
mpvSettingsTarget    := "$(shell ./defaultPath.sh mpv ${OS})"/mpv.conf
mpsytPlaylistTargets := ${mpsytPlaylistSources}

mpsytPlaylistTargetsFull := $(addprefix "$(shell ./defaultPath.sh mpsyt ${OS})"/playlists/,${mpsytPlaylistSources})

targetFiles := \
	${muttSettingsTarget} \
	${gitSettingsTarget} \
	${topSettingsTarget} \
	${tmuxSettingsTarget} \
	${mpvSettingsTarget}

all:
	for file in ${targetFiles}; do \
		cp $$file . ; \
	done
	for file in ${mpsytPlaylistTargetsFull}; do \
		cp $$file ${mpsytPlaylistDir}; \
	done

install:
	cp ${muttSettingsSource} ${muttSettingsTarget}
	cp ${gitSettingsSource}  ${gitSettingsTarget}
	cp ${topSettingsSource}  ${topSettingsTarget}
	cp ${tmuxSettingsSource} ${tmuxSettingsTarget}
	cp ${mpvSettingsSource}  ${mpvSettingsTarget}
	i=1; \
	for source in ${mpsytPlaylistSourcesFull}; do \
		 target=$$(echo ${mpsytPlaylistTargetsFull} | cut -d' ' -f$$i); \
		 cp $$source $$target; \
		 i=$$(( $i + 1 )); \
	done

uninstall:
	rm ${targetFiles}
