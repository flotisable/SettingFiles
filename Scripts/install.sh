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
  sourceFile=$1
  targetFile=$2
  ifInstall=$3
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
  if [ "${ifInstall}" = "1" ]; then
    echo "install ${sourceFile}"
    cp "${sourceFile}" "${targetFile}"
  fi
  # end install file}}}
}
# end function definition
#}}}
# install setting files{{{
targetTableName=$(mapFind "settings" "target")
sourceTableName=$(mapFind "settings" "source")
installTableName=$(mapFind "settings" "install")

for target in $(mapKeys "$targetTableName"); do

  if [ "$target" == "playlistDir" ]; then

    for playlist in $(mapFind "$sourceTableName" "playlist"); do

      sourceFile="$(mapFind "$sourceTableName" "$target")/$playlist"
      targetFile="$(mapFind "$targetTableName" "$target")/$playlist"

      installSettings $sourceFile $targetFile $(mapFind "$installTableName" "playlist")

    done
    
  else

    installSettings $(mapFind "$sourceTableName" "$target") $(mapFind "$targetTableName" "$target") $(mapFind "$installTableName" "$target")

  fi

done
# end install setting files}}}
# vim: foldmethod=marker foldmarker={{{,}}}
