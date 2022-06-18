$settingFile = "./settings.toml"

$scriptDir = "$(Split-Path $PSCommandPath)"

. ${scriptDir}/readSettings.ps1 $settingFile

ForEach( $target in $settings['target'].keys )
{
  $targetFile = Invoke-Expression "Write-Output $($settings['target'][$target])"
  $sourceFile = Invoke-Expression "Write-Output $($settings['source'][$target])"

  If( !( Get-Item -Force -ErrorAction SilentlyContinue $targetFile ) )
  {
    Continue
  }

  If( $target -eq 'playlistDir' -and ( Test-Path $targetFile -PathType Container ) )
  {
    ForEach( $playlist in $settings['source']['playlist'] )
    {
      Write-Host "copy $playlist to $sourceFile"
      Copy-Item $targetFile/$playlist $sourceFile
    }
    Continue
  }
  Write-Host "copy $targetFile to $sourceFile"
  Copy-Item $targetFile $sourceFile
}
