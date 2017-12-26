muttSettingsSource	= .muttrc
gitSettingsSource		= .gitconfig

muttSettingsTarget	= $(HOME)/.muttrc
gitSettingsTarget		= $(HOME)/.gitconfig

targetFiles = $(muttSettingsTargte) $(gitSettingsTarget)

all:
	mv $(targetFiles) .

install:
	cp $(muttSettingsSource) 	$(muttSettingsTarget)
	cp $(gitSettingsSource) 	$(gitSettingsTarget)

uninstall:
	rm $(targetFiles)
