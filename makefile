mpsytPlaylistDir := MpsytPlaylist

muttSettingsSource   := .muttrc
gitSettingsSource    := .gitconfig
topSettingsSource    := .toprc
tmuxSettingsSource   := .tmux.conf
mpsytPlaylistSources := favorite.m3u

mpsytPlaylistSourcesFull := $(addprefix ${mpsytPlaylistDir}/,${mpsytPlaylistSources})

muttSettingsTarget   := ${HOME}/.muttrc
gitSettingsTarget    := ${HOME}/.gitconfig
topSettingsTarget    := ${HOME}/.toprc
tmuxSettingsTarget   := ${HOME}/.tmux.conf
mpsytPlaylistTargets := ${mpsytPlaylistSources}

mpsytPlaylistTargetsFull := $(addprefix ${HOME}/.config/mps-youtube/playlists/,${mpsytPlaylistSources})

targetFiles := \
	${muttSettingsTarget} \
	${gitSettingsTarget} \
	${topSettingsTarget} \
	${tmuxSettingsTarget}

all:
	for file in ${targetFiles}; do \
		cp $$file . ; \
	done
	for file in ${mpsytPlaylistTargetsFull}; do \
		cp $$file ${mpsytPlaylistDir}; \
	done

install:
	cp ${muttSettingsSource} 	${muttSettingsTarget}
	cp ${gitSettingsSource} 	${gitSettingsTarget}
	cp ${topSettingsSource} 	${topSettingsTarget}
	cp ${tmuxSettingsSource} 	${tmuxSettingsTarget}
	for(( i=1 ; $$i <= $(words ${mpsytPlaylistSources}) ; i++ )); do \
		 source=$$(echo ${mpsytPlaylistSourcesFull} | cut -d' ' -f$$i); \
		 target=$$(echo ${mpsytPlaylistTargetsFull} | cut -d' ' -f$$i); \
		 cp $$source $$target; \
	done

uninstall:
	rm ${targetFiles}
