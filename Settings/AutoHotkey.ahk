#SingleInstance Force

SetTitleMatchMode RegEx

wezTermClassName := "org.wezfurlong.wezterm"

F12::
If( WinExist( "ahk_class " . wezTermClassName ) )
{
  If( WinActive(  "ahk_class " . wezTermClassName  ) )
  {
    WinClose, % "ahk_class " . wezTermClassName
  }
  Else
  {
    WinActivate, % "ahk_class " . wezTermClassName
  }
}
Else
{
  Run, wezterm-gui start
}
