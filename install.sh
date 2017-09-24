#/bin/sh

initSourceName=".emacs"
initTargetName=".emacs"
targetDir=${HOME}

if [ -n $1 ]; then initSourceName=$1; fi
if [ -n $2 ]; then targetDir=$2;      fi
if [ -n $3 ]; then initSourceName=$3; fi

cp ${initSourceName} ${targetDir}/${initTargetName}
