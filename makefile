muttSettingsSource  := .muttrc
gitSettingsSource   := .gitconfig

muttSettingsTarget  := $(HOME)/.muttrc
gitSettingsTarget   := $(HOME)/.gitconfig

targetFiles := \
	$(muttSettingsTarget) \
	$(gitSettingsTarget)

all:
	for file in $(targetFiles); do \
		cp $$file . ;\
	done

install:
	cp $(muttSettingsSource) 	$(muttSettingsTarget)
	cp $(gitSettingsSource) 	$(gitSettingsTarget)

uninstall:
	rm $(targetFiles)
