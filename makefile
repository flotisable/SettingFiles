OS ?= $(shell uname -s)

include settings

mpsytPlaylistSourcesFull := $(addprefix ${mpsytPlaylistSourceDir}/,${mpsytPlaylistSources})

# setup default value
ifeq "${mpsytPlaylistTargetDir}" ""
mpsytPlaylistTargetDir := $(shell ./defaultPath.sh mpsyt ${OS})
endif
ifeq "${muttSettingsTarget}" ""
muttSettingsTarget := $(shell ./defaultPath.sh mutt ${OS})
endif
ifeq "${gitSettingsTarget}" ""
gitSettingsTarget := $(shell ./defaultPath.sh git ${OS})
endif
ifeq "${topSettingsTarget}" ""
topSettingsTarget := $(shell ./defaultPath.sh top ${OS})
endif
ifeq "${tmuxSettingsTarget}" ""
tmuxSettingsTarget := $(shell ./defaultPath.sh tmux ${OS})
endif
ifeq "${screenSettingsTarget}" ""
screenSettingsTarget := $(shell ./defaultPath.sh screen ${OS})
endif
ifeq "${mpvSettingsTarget}" ""
mpvSettingsTarget := $(shell ./defaultPath.sh mpv ${OS})/mpv.conf
endif
# setup default value

mpsytPlaylistTargetsFull := $(addprefix ${mpsytPlaylistTargetDir}/,${mpsytPlaylistSources})

targetFiles := \
	${muttSettingsTarget} \
	${gitSettingsTarget} \
	${topSettingsTarget} \
	${tmuxSettingsTarget} \
	${screenSettingsTarget} \
	${mpvSettingsTarget}

all:
	@for file in ${targetFiles}; do \
		echo "copy $$file"; \
		cp "$$file" . ; \
	done
	@for file in ${mpsytPlaylistTargetsFull}; do \
		echo "copy $$file"; \
		cp "$$file" ${mpsytPlaylistSourceDir}; \
	done

install:
	@./install.sh

install-interactive:
	@./install.sh -i

uninstall:
	rm ${targetFiles}
