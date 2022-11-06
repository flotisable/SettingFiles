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

  use_fancy_tab_bar                     = false,
  tab_bar_at_bottom                     = true,
  tab_and_split_indices_are_zero_based  = true,

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

-- statusline
wezterm.on( 'update-status',
  function( window, pane )

    local date          = wezterm.strftime( '%Y-%m-%d %p %H:%M' )
    local workspace     = window:mux_window():get_workspace()
    local leader_colors =
    {
      active    = 'red',
      inactive  = 'gray',
    }
    local leader_color

    if window:leader_is_active() then
      leader_color = leader_colors.active
    else
      leader_color = leader_colors.inactive
    end

    window:set_left_status(
      wezterm.format(
        {
          { Background  = { Color = leader_color } },
          { Text        = ' ' .. workspace .. ' ' },
        }
      )
    )

    window:set_right_status(
      wezterm.format(
        {
          { Background  = { Color = 'teal' } },
          { Text        = ' ' .. date .. ' ' },
        }
      )
    )

  end
)
-- end statusline

return config
