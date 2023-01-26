#!/bin/sh
settingFile="./settings.toml"

scriptDir="$(dirname $0)"

# process arguments{{{
if [ "$1" = "--interactive" -o "$1" = "-i" ]; then
  ifInterActive=1
else
  ifInterActive=0
fi
# end process arguments
#}}}
. ${scriptDir}/readSettings.sh ${settingFile}

# function definition{{{
installSettings()
{
  # function arguments{{{
  local sourceFile=$1
  local targetFile=$2
  # end function arguments
#}}}
  # interactive mode{{{
  if [ "${ifInterActive}" = "1" ]; then
  {
    echo "do you want to install ${sourceFile} [y/n]? "

    while read value; do
    {
      case ${value} in

        "y" ) ifInstall=1; break;;
        "n" ) ifInstall=0; break;;
        *   ) echo "invalid input!";;

      esac
    }
    done
  }
  fi
  # end interactive mode
#}}}
  # install file{{{
  local dir
  dir="$(dirname $targetFile)"

  mkdir -vp $dir  
  echo "install ${sourceFile}"
  cp "${sourceFile}" "${targetFile}"
  # end install file}}}
}
# end function definition
#}}}
# install setting files{{{
dirTableName=$(mapFind "settings" "dir")

root=$(mapFind "$dirTableName" "root")

for file in $(find -L "Settings/$os" -type f -printf '%P\n'); do

  targetFile="$root/$file"
  sourceFile="Settings/$os/$file"

  installSettings $sourceFile $targetFile

done
# end install setting files}}}
# vim: foldmethod=marker foldmarker={{{,}}}
