# keybindings
If( Get-Command -ErrorAction SilentlyContinue Set-PSReadLineOption )
{
  Set-PSReadLineOption -EditMode Emacs
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
