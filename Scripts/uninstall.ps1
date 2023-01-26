$settingFile = "./settings.toml"

$scriptDir = "$(Split-Path $PSCommandPath )"

. ${scriptDir}/readSettings.ps1 $settingFile

$root           = Invoke-Expression "Write-Output $($settings['dir']['root'])"
$rcRoot         = ( Get-Item ${scriptDir}/../Settings/$os ).FullName
$rcRootPattern  = "$( $rcRoot -replace '\\', '\\' )\\"

Function removeFile( $file )
{
  Write-Host "uninstall $file"
  Remove-Item -Force -ErrorAction SilentlyContinue $file
}

# install setting files{{{
ForEach( $file in ( Get-ChildItem -Recurse -File $rcRoot ).FullName )
{
  $file       = $file -replace $rcRootPattern, ""
  $targetFile = "$root/$file"

  removeFile $targetFile
}
# end install setting files}}}
# vim: foldmethod=marker foldmarker={{{,}}}
