#!/bin/sh

. ./readSettings.sh "./settings.toml"

removeFile()
{
  local fileName=$1

  echo "remove $fileName"
  rm $fileName
}

# install setting files{{{
targetTableName=$(mapFind "settings" "target")
sourceTableName=$(mapFind "settings" "source")

for target in $(mapKeys "$targetTableName"); do

  if [ "$target" == "playlistDir" ]; then

    for playlist in $(mapFind "$sourceTableName" "playlist"); do

      removeFile "$(mapFind "$targetTableName" "$target")/${playlist}"

    done

  else

    removeFile "$(mapFind "$targetTableName" "$target")"

  fi

done
# end install setting files}}}
# vim: foldmethod=marker foldmarker={{{,}}}
