-- wezterm variables
local wezterm = require 'wezterm'
local act     = wezterm.action
-- end wezterm variables

local default_unix_domain = 'default'
local min_window_width    = '80'

local toggleStatusLineEvent         = 'ToggleStatusLineEvent'
local toggleWindowPaddingEvent      = 'ToggleWindowPaddingEvent'
local toggleBackgroundOpacityEvent  = 'ToggleBackgroundOpacityEvent'
-- basic configs
local config =
{
  -- appearance settings
  color_scheme  = 'nord',

  use_fancy_tab_bar                     = false,
  tab_bar_at_bottom                     = true,
  tab_and_split_indices_are_zero_based  = true,

  window_background_opacity = 0.8,

  adjust_window_size_when_changing_font_size = false,
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
  keys    =
  {
    { key = 'F11',  action = act.ToggleFullScreen                               },
    -- Ctrl + ^ is used in vim to switch to alternative buffer
    { key = '^',    action = act.DisableDefaultAssignment,  mods = 'CTRL|SHIFT' },
  },
  -- end keybindings
}
-- end basic configs

-- Windows specific settings
if wezterm.target_triple == 'x86_64-pc-windows-msvc' then

  config.default_prog = { 'powershell' }
  config.font         = wezterm.font( 'Consolas' )
  config.font_size    = 14

end
-- end Windows specific settings

-- Linux specific settings
if wezterm.target_triple == 'x86_64-unknown-linux-gnu' then

  config.default_prog = { 'bash' }
  config.font         = wezterm.font_with_fallback( {
                                                      'DejaVu Sans Mono',
                                                      'AR PL New Kai'
                                                    } )
  config.font_size    = 14

end
-- end Linux specific settings

-- simulate tmux keys
local function addLeaderBinding( key, action, modsWithoutLeader )

  local mods = 'LEADER'

  if modsWithoutLeader then
    mods = mods .. '|' .. modsWithoutLeader
  end

  table.insert( config.keys, { key = key, mods = mods, action = action })

end

addLeaderBinding( 'c',    act.SpawnTab 'CurrentPaneDomain'                                )
addLeaderBinding( 'n',    act.ActivateTabRelative( 1  )                                   )
addLeaderBinding( 'p',    act.ActivateTabRelative( -1 )                                   )
addLeaderBinding( '%',    act.SplitHorizontal( { domain = 'CurrentPaneDomain' }), 'SHIFT' )
addLeaderBinding( '"',    act.SplitVertical(   { domain = 'CurrentPaneDomain' }), 'SHIFT' )
addLeaderBinding( '[',    act.ActivateCopyMode                                            )
addLeaderBinding( 'w',    act.ShowTabNavigator                                            )
addLeaderBinding( 'h',    act.ActivatePaneDirection 'Left'                                )
addLeaderBinding( 'j',    act.ActivatePaneDirection 'Down'                                )
addLeaderBinding( 'k',    act.ActivatePaneDirection 'Up'                                  )
addLeaderBinding( 'l',    act.ActivatePaneDirection 'Right'                               )
addLeaderBinding( 'o',    act.EmitEvent( toggleBackgroundOpacityEvent )                   )
addLeaderBinding( 'F10',  act.EmitEvent( toggleStatusLineEvent        )                   )
addLeaderBinding( 'C',    act.EmitEvent( toggleWindowPaddingEvent     )                   )
addLeaderBinding( ',',    act.PromptInputLine
                          {
                            description = 'Enter new name for current tab',
                            action      = wezterm.action_callback(
                              -- modify current tab name
                              function( window, pane, line )
                                if line then
                                  window:active_tab():set_title( line )
                                end
                              end
                            )
                          } )

for i = 0, 9, 1 do
  addLeaderBinding( tostring( i ), act.ActivateTab( i ) )
end
-- end simulate tmux keys

-- statusline
wezterm.on( 'update-status',
  function( window, pane )

    local day           = wezterm.strftime( '%Y-%m-%d' )
    local apm           = wezterm.strftime( '%p' )
    local apmSymbol     =
    {
      am = '🔆',
      pm = '🌙',
    }
    local time          = wezterm.strftime( '%H:%M' )
    local date
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

    if apm == 'AM' then
      apm = apmSymbol.am
    else
      apm = apmSymbol.pm
    end

    date = day .. ' ' .. apm .. ' ' .. time

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

wezterm.on( toggleBackgroundOpacityEvent,
  function( window, pane )

    local overrides = window:get_config_overrides() or {}
    local opaque    = 1.0

    if not overrides.window_background_opacity then
      overrides.window_background_opacity = opaque
    else
      overrides.window_background_opacity = nil
    end

    window:set_config_overrides( overrides )

  end
)

wezterm.on( toggleStatusLineEvent,
  function( window, pane )

    local overrides = window:get_config_overrides() or {}

    if overrides.enable_tab_bar == nil then
      overrides.enable_tab_bar = false
    else
      overrides.enable_tab_bar = nil
    end

    window:set_config_overrides( overrides )

  end
)

wezterm.on( toggleWindowPaddingEvent,
  function( window, pane )

    local overrides = window:get_config_overrides() or {}

    -- make window width max( window_width / 2, min_window_width )
    local window_width  = window:get_dimensions().pixel_width
    local padding       = math.min( window_width / 4, ( window_width - min_window_width ) / 2 )

    if not overrides.window_padding then

      overrides.window_padding = {
                                    left   = padding,
                                    right  = padding
                                 }

    elseif overrides.window_padding.left == padding then

      overrides.window_padding.left   = nil
      overrides.window_padding.right  = nil

    else

      overrides.window_padding.left   = padding
      overrides.window_padding.right  = padding

    end

    window:set_config_overrides( overrides )

  end
)
return config
