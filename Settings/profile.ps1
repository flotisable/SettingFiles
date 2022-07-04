# keybindings
Set-PSReadlineOption -EditMode Emacs

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

Invoke-Expression (&starship init powershell)
