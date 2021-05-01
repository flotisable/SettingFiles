Param(
  $targetFiles,
  $mpsytPlaylistTargetsFull,
  $mpsytPlaylistSourceDir
)

ForEach( $file in ${targetFiles} )
{
  Write-Host "copy $file"
  Copy-Item -ErrorAction SilentlyContinue "$file" .
}

ForEach( $file in ${mpsytPlaylistTargetsFull} )
{
  Write-Host "copy $file"
  Copy-Item -ErrorAction SilentlyContinue "$file" $mpsytPlaylistSourceDir
}
