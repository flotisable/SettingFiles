#SingleInstance Force

SetTitleMatchMode RegEx

wezTermClassName  := "org.wezfurlong.wezterm"
isWezTermHidden   := 0

F12::
If( isWezTermHidden == 1 )
{
  WinShow,      % "ahk_class " . wezTermClassName
  WinActivate,  % "ahk_class " . wezTermClassName
  isWezTermHidden := 0
}
Else If( WinExist( "ahk_class " . wezTermClassName ) )
{
  If( WinActive(  "ahk_class " . wezTermClassName  ) )
  {
    WinHide, % "ahk_class " . wezTermClassName
    isWezTermHidden := 1
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
