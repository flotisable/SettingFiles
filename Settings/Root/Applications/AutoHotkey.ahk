#SingleInstance Force

SetTitleMatchMode( "RegEx" )

wezTermClassName  := "org.wezfurlong.wezterm"
wezTermWid        := ""
isWezTermHidden   := 0

ToggleTerminal()
{
  global isWezTermHidden
  global wezTermWid

  If( isWezTermHidden == 1 )
  {
    WinShow(      "ahk_id " . wezTermWid )
    WinActivate(  "ahk_id " . wezTermWid )
    isWezTermHidden := 0
  }
  Else If( WinExist( "ahk_id " . wezTermWid ) )
  {
    If( WinActive( "ahk_id " . wezTermWid  ) )
    {
      WinHide( "ahk_id " . wezTermWid )
      isWezTermHidden := 1
    }
    Else
    {
      WinActivate( "ahk_id " . wezTermWid )
    }
  }
  Else
  {
    widsBefore := WinGetList( "ahk_class" . wezTermClassName )
    Run( "wezterm-gui start --domain default --attach" )
    widsAfter := WinGetList( "ahk_class" . wezTermClassName )

    While( widsBefore.Length == widsAfter.Length )
    {
      Sleep 1
      widsAfter := WinGetList( "ahk_class" . wezTermClassName )
    }

    For wid in widsAfter
    {
      isInWidsBefore := 0

      For wid2 in widsBefore
      {
        If( wid == wid2 )
        {
          isInWidsBefore := 1
          Break
        }
      }
      If( isInWidsBefore )
      {
        Continue
      }
      wezTermWid := wid
      Break
    }
  }
}

OpenSensibleTerminal()
{
  Try
    Try
      Try
        Run( "wezterm-gui")
      Catch
        Run( "wt")
    Catch
      Run( "powershell" )
  Catch
    Run( "cmd" )
}

F12::ToggleTerminal()
!=::ToggleTerminal()
!;::OpenSensibleTerminal()
