OS ?= $(shell uname -s)

scriptDir := Scripts

.PHONY: default copy install install-interactive uninstall
default: copy

copy:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./${scriptDir}/copy.ps1
else
	@./${scriptDir}/copy.sh
endif

install:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./${scriptDir}/install.ps1
else
	@./${scriptDir}/install.sh
endif

install-interactive:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./${scriptDir}/install.ps1 -interactive
else
	@./${scriptDir}/install.sh -i
endif

uninstall:
ifeq "${OS}" "Windows_NT"
	@powershell -NoProfile ./${scriptDir}/uninstall.ps1
else
	@./${scriptDir}/uninstall.sh
endif
