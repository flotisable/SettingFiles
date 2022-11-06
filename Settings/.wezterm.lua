-- wezterm variables
local wezterm = require 'wezterm'
-- end wezterm variables

local default_unix_domain = 'default'

-- basic configs
local config =
{
  -- appearance settings
  color_scheme  = 'nord',

  hide_tab_bar_if_only_one_tab  = true,
  use_fancy_tab_bar             = false,
  tab_bar_at_bottom             = true,

  window_background_opacity = 0.8,
  -- end appearance settings

  -- multiplexing settings
  unix_domains =
  {
    {
      name = default_unix_domain,
    },
  },
  default_gui_startup_args = { 'connect', default_unix_domain },
  -- end multiplexing settings
}
-- end basic configs

-- Windows specific settings
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then

  config.default_prog  = { 'powershell' }
  config.font          = wezterm.font( 'Consolas' )

end
-- end Windows specific settings

return config
