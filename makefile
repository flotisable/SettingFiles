OS ?= $(shell uname -s)

default: copy

copy:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./copy.ps1
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
