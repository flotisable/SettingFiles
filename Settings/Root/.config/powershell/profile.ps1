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

  Set-PSReadLineKeyHandler -Chord 'Ctrl+x,d' -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    $path = $(vifm --choose-dir - .)

    If ( $path )
    {
      [Microsoft.PowerShell.PSConsoleReadLine]::Insert( "cd $path" )
      [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
    }
  }
  Set-PSReadLineKeyHandler -Chord 'Ctrl+x,v' -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert( "lazygit" )
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  }
  Set-PSReadLineKeyHandler -Chord 'Ctrl+x,g' -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::RevertLine()
    [Microsoft.PowerShell.PSConsoleReadLine]::Insert( "gemini" )
    [Microsoft.PowerShell.PSConsoleReadLine]::AcceptLine()
  }
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
  emacsclientw -ca "`"`"" $Args
}

If( (Get-Command -ErrorAction SilentlyContinue starship) -and $PSVersionTable.PSVersion.Major -ge 5 )
{
  Invoke-Expression (&starship init powershell)
}

If( Get-Command -ErrorAction SilentlyContinue zoxide )
{
  Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --cmd cd --hook $hook powershell | Out-String)
  })
}
