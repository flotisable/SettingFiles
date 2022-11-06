-- wezterm variables
local wezterm = require 'wezterm'
local act     = wezterm.action
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
  default_domain = default_unix_domain,
  -- end multiplexing settings

  -- keybindings
  leader  = { key = 'a', mods = 'ALT' },
  keys    = {},
  -- end keybindings
}
-- end basic configs

-- Windows specific settings
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then

  config.default_prog  = { 'powershell' }
  config.font          = wezterm.font( 'Consolas' )

end
-- end Windows specific settings

-- simulate tmux keys
local function addLeaderBinding( key, action, modsWithoutLeader )

  local mods = 'LEADER'

  if modsWithoutLeader then
    mods = mods .. '|' .. modsWithoutLeader
  end

  table.insert( config.keys, { key = key, mods = mods, action = action })

end

addLeaderBinding( 'c', act.SpawnTab 'CurrentPaneDomain'                       )
addLeaderBinding( 'n', act.ActivateTabRelative( 1  )                          )
addLeaderBinding( 'p', act.ActivateTabRelative( -1 )                          )
addLeaderBinding( '%', act.SplitHorizontal  { domain = 'CurrentPaneDomain' }  )
addLeaderBinding( '"', act.SplitVertical    { domain = 'CurrentPaneDomain' }  )

for i = 0, 9, 1 do
  addLeaderBinding( tostring( i ), act.ActivateTab( i ) )
end
-- end simulate tmux keys

-- start GUI maxmized
wezterm.on( 'gui-startup',
  function( cmd )

    local tab, pane, window = wezterm.mux.spawn_window( cmd or {} )

    window:gui_window():maximize()

  end
)
-- end start GUI maxmized

return config
