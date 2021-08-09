OS ?= $(shell uname -s)

include settings

empty :=
comma := ,

ifeq "${OS}" "Windows_NT"
	defaultScript := powershell -NoProfile ./defaultPath.ps1
else
	defaultScript := ./defaultPath.sh
endif

mpsytPlaylistSourcesFull := $(addprefix ${mpsytPlaylistSourceDir}/,${mpsytPlaylistSources})

# setup default value
ifeq "${mpsytPlaylistTargetDir}" ""
mpsytPlaylistTargetDir := $(shell ${defaultScript} mpsyt ${OS})
endif
ifeq "${muttSettingsTarget}" ""
muttSettingsTarget := $(shell ${defaultScript} mutt ${OS})
endif
ifeq "${gitSettingsTarget}" ""
gitSettingsTarget := $(shell ${defaultScript} git ${OS})
endif
ifeq "${topSettingsTarget}" ""
topSettingsTarget := $(shell ${defaultScript} top ${OS})
endif
ifeq "${tmuxSettingsTarget}" ""
tmuxSettingsTarget := $(shell ${defaultScript} tmux ${OS})
endif
ifeq "${screenSettingsTarget}" ""
screenSettingsTarget := $(shell ${defaultScript} screen ${OS})
endif
ifeq "${mpvSettingsTarget}" ""
mpvSettingsTarget := "$(shell ${defaultScript} mpv ${OS})/mpv.conf"
endif
ifeq "${starshipSettingsTarget}" ""
starshipSettingsTarget := "$(shell ${defaultScript} starship ${OS})"
endif
ifeq "${efmLanguageServerSettingsTarget}" ""
efmLanguageServerSettingsTarget := "$(shell ${defaultScript} efmLanguageServer ${OS})"
endif
# setup default value

mpsytPlaylistTargetsFull := $(foreach path,$(addprefix ${mpsytPlaylistTargetDir}/,$(subst ",,${mpsytPlaylistSources})),"${path}")

targetFiles := \
	${muttSettingsTarget} \
	${gitSettingsTarget} \
	${topSettingsTarget} \
	${tmuxSettingsTarget} \
	${screenSettingsTarget} \
	${mpvSettingsTarget} \
	${starshipSettingsTarget}

all:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./copy.ps1 \
		$(subst ${empty} ${empty},${comma},${targetFiles}) \
		$(subst ${empty} ${empty},${comma},${mpsytPlaylistTargetsFull}) \
		${mpsytPlaylistSourceDir}
	@powershell -NoProfile -Command "Copy-Item ${efmLanguageServerSettingsTarget} ${efmLanguageServerSettingsSource}"

else
	@./copy.sh
endif

install:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./install.ps1
else
	@./install.sh
endif

install-interactive:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./install.ps1 -interactive
else
	@./install.sh -i
endif

uninstall:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./uninstall.ps1
else
	@./uninstall.sh
endif
