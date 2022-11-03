local wezterm = require 'wezterm'

local default_unix_domain = 'default'

local config =
{
  color_scheme  = 'nord',

  hide_tab_bar_if_only_one_tab  = true,
  use_fancy_tab_bar             = false,
  tab_bar_at_bottom             = true,

  window_background_opacity = 0.8,
}

if wezterm.target_triple == 'x86_64-pc-windows-msvc' then

  config.default_prog  = { 'powershell' }
  config.font          = wezterm.font( 'Consolas' )

end

return config
