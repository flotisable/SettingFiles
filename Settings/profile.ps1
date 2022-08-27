# keybindings
If( Get-Command -ErrorAction SilentlyContinue Set-PSReadLineOption )
{
  Set-PSReadLineOption -EditMode Emacs -HistoryNoDuplicates

  $version = (Get-Module PSReadLine).Version

  If( $version.Major -eq 2 -and $version.Minor -ge 1 -or $version.Major -ge 3 )
  {
    Set-PSReadLineOption -PredictionSource History
  }
  If( $version.Major -eq 2 -and $version.Minor -ge 2 -or $version.Major -ge 3 )
  {
    Set-PSReadLineOption -PredictionViewStyle ListView
  }
  Remove-Variable version
}

# environment settings
$env:HOME = "$env:USERPROFILE"

# aliases
New-Alias emacs 'Start-Emacs'

# chocolatry profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

if ( Test-Path( $ChocolateyProfile ) )
{
  Import-Module "$ChocolateyProfile"
}

Function Start-Emacs()
{
  emacsclientw -ca "`"`""
}

If( $PSVersionTable.PSVersion.Major -ge 5 )
{
  Invoke-Expression (&starship.exe init powershell)
}

Invoke-Expression (& {
  $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
  (zoxide init --cmd cd --hook $hook powershell | Out-String)
})
