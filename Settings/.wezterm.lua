local wezterm = require 'wezterm'

return
{
  default_prog  = { 'powershell' },

  color_scheme  = 'nord',
  font          = wezterm.font( 'Consolas' ),

  hide_tab_bar_if_only_one_tab  = true,
  use_fancy_tab_bar             = false,
  tab_bar_at_bottom             = true,

  window_background_opacity = 0.8,
}
