#!/bin/sh
settingFile="./settings.toml"

scriptDir="$(dirname $0)"

. ${scriptDir}/readSettings.sh ${settingFile}

removeFile()
{
  local fileName=$1

  echo "remove $fileName"
  rm -f $fileName
}

# install setting files{{{
dirTableName=$(mapFind "settings" "dir")
pluginManagerTableName=$(mapFind "settings" "pluginManager")

root=$(mapFind "$dirTableName" "root")

for file in $(find -L "Settings/$os" -type f -printf '%P\n'); do

  targetFile="$root/$file"
  sourceFile="Settings/$os/$file"

  removeFile $targetFile

done
# end install setting files}}}
# vim: foldmethod=marker foldmarker={{{,}}}
