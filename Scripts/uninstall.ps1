$settingFile = "./settings.toml"

$scriptDir = "$(Split-Path $PSCommandPath )"

. ${scriptDir}/readSettings.ps1 $settingFile

Function removeFile( $file )
{
  Write-Host "remove $file"
  Remove-Item $file
}

# install setting files{{{
ForEach( $target in $settings['target'].keys )
{
  $targetFile = Invoke-Expression "Write-Output $($settings['target'][$target])"

  If( $target -eq 'playlistDir' )
  {
    If( Test-Path $targetFile -PathType Container )
    {
      ForEach( $playlist in $settings['source']['playlist'] )
      {
        removeFile $targetFile/$playlist
      }
    }
    Continue
  }
  removeFile $targetFile
}
# end install setting files}}}
# vim: foldmethod=marker foldmarker={{{,}}}
