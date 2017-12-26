#!/bin/sh

initSourceName=".emacs"
initTargetName=".emacs"
targetDir=${HOME}

if [ $# -eq 1 -a -n $1 ]; then initSourceName=$1; fi
if [ $# -eq 2 -a -n $2 ]; then targetDir=$2;      fi
if [ $# -eq 3 -a -n $3 ]; then initTargetName=$3; fi

cp ${initSourceName} ${targetDir}/${initTargetName}
