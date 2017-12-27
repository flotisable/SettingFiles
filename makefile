muttSettingsSource  := .muttrc
gitSettingsSource   := .gitconfig
topSettingsSource   := .toprc
tmuxSettingsSource  := .tmux.conf

muttSettingsTarget  := $(HOME)/.muttrc
gitSettingsTarget   := $(HOME)/.gitconfig
topSettingsTarget   := $(HOME)/.toprc
tmuxSettingsTarget  := $(HOME)/.tmux.conf

targetFiles := \
	$(muttSettingsTarget) \
	$(gitSettingsTarget) \
	$(topSettingsTarget) \
	$(tmuxSettingsTarget)

all:
	for file in $(targetFiles); do \
		cp $$file . ;\
	done

install:
	cp $(muttSettingsSource) 	$(muttSettingsTarget)
	cp $(gitSettingsSource) 	$(gitSettingsTarget)
	cp $(topSettingsSource) 	$(topSettingsTarget)
	cp $(tmuxSettingsSource) 	$(tmuxSettingsTarget)

uninstall:
	rm $(targetFiles)
