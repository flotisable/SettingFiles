#!/bin/sh
settingFile="./settings.toml"

scriptDir="$(dirname $0)"

. ${scriptDir}/readSettings.sh ${settingFile}

targetTableName=$(mapFind "settings" "target")
sourceTableName=$(mapFind "settings" "source")

for target in $(mapKeys "$targetTableName"); do

  targetFile=$(mapFind "$targetTableName" "$target")
  sourceFile=$(mapFind "$sourceTableName" "$target")

  if [ -r "$targetFile" ]; then

    if [ "$target" == "playlistDir" -a -d "$targetFile" ]; then

      for playlist in $(mapFind "$sourceTableName" "playlist"); do

        echo "copy $playlist to $sourceFile"
        cp $targetFile/$playlist $sourceFile

      done
      continue

    fi

    echo "copy $targetFile to $sourceFile"
    cp $targetFile $sourceFile

  fi

done
