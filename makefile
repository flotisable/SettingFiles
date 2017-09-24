initSourceName=.emacs
initTargetName=.emacs
targetDir=$(HOME)

all: $(targetDir)/$(initTargetName)
	cp $< .

install:
	./install.sh $(initSourceName) $(targetDir) $(initTargetName)
