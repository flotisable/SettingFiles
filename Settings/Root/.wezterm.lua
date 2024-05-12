-- wezterm variables
local wezterm = require 'wezterm'
local act     = wezterm.action
-- end wezterm variables

local default_unix_domain     = 'default'
local min_window_columns      = '80'
local default_window_padding  =
  {
    bottom = '0px',
  }

local toggleStatusLineEvent         = 'ToggleStatusLineEvent'
local toggleWindowPaddingEvent      = 'ToggleWindowPaddingEvent'
local toggleBackgroundOpacityEvent  = 'ToggleBackgroundOpacityEvent'
local toggleInternalTerminalEvent   = 'ToggleInternalTerminalEvent'

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

  window_padding = default_window_padding,
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
    { key = 'F10',  action = act.EmitEvent( toggleInternalTerminalEvent )       },
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

local function addCopyModeBinding( key, action, mods )

  local copyMode = nil

  if config.key_tables then
    copyMode = config.key_tables.copy_mode
  end

  if not copyMode and wezterm.gui then
    copyMode = wezterm.gui.default_key_tables().copy_mode
  end

  if copyMode then

    table.insert( copyMode, { key = key, mods = mods, action = action })

    if config.key_tables then
      config.key_tables.copy_mode = copyMode
    else
      config.key_tables = { copy_mode = copyMode, }
    end

  end

end


addCopyModeBinding( 'Enter',  act.Multiple
                              {
                                act.CopyTo( 'ClipboardAndPrimarySelection' ),
                                act.CopyMode( 'Close' ),
                              } )

addLeaderBinding( 'c',    act.SpawnTab 'CurrentPaneDomain'                                  )
addLeaderBinding( 'n',    act.ActivateTabRelative( 1  )                                     )
addLeaderBinding( 'p',    act.ActivateTabRelative( -1 )                                     )
addLeaderBinding( '%',    act.SplitHorizontal(  { domain = 'CurrentPaneDomain' } ), 'SHIFT' )
addLeaderBinding( '"',    act.SplitVertical(    { domain = 'CurrentPaneDomain' } ), 'SHIFT' )
addLeaderBinding( '|',    act.SplitHorizontal(  { domain = 'CurrentPaneDomain' } ), 'SHIFT' )
addLeaderBinding( '-',    act.SplitVertical(    { domain = 'CurrentPaneDomain' } )          )
addLeaderBinding( '[',    act.ActivateCopyMode                                              )
addLeaderBinding( ']',    act.PasteFrom( 'Clipboard' )                                      )
addLeaderBinding( 'w',    act.ShowTabNavigator                                              )
addLeaderBinding( 'h',    act.ActivatePaneDirection 'Left'                                  )
addLeaderBinding( 'j',    act.ActivatePaneDirection 'Down'                                  )
addLeaderBinding( 'k',    act.ActivatePaneDirection 'Up'                                    )
addLeaderBinding( 'l',    act.ActivatePaneDirection 'Right'                                 )
addLeaderBinding( 'o',    act.EmitEvent( toggleBackgroundOpacityEvent )                     )
addLeaderBinding( 'F10',  act.EmitEvent( toggleStatusLineEvent        )                     )
addLeaderBinding( 'C',    act.EmitEvent( toggleWindowPaddingEvent     )                     )
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
local color = wezterm.color.get_builtin_schemes()[config.color_scheme]

config.colors =
{
  tab_bar =
  {
    background = color.background,

    active_tab =
    {
      fg_color = color.brights[8],
      bg_color = color.ansi[7],
    },

    inactive_tab =
    {
      fg_color  = color.ansi[8],
      bg_color  = color.ansi[1],
    },

    inactive_tab_hover =
    {
      fg_color  = color.ansi[8],
      bg_color  = '#5E81AC',
      italic    = true,
    },

    new_tab =
    {
      fg_color  = color.ansi[8],
      bg_color  = color.ansi[1],
    },


    new_tab_hover =
    {
      fg_color  = color.ansi[8],
      bg_color  = '#5E81AC',
      italic    = true,
    },
  }
}

wezterm.on( 'update-status',
  function( window, pane )

    local red           = color.brights[2]
    local grey          = color.brights[1]
    local navy          = color.ansi[5]
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
      active    = red,
      inactive  = grey,
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
          { Background  = { Color = navy } },
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
    local column_to_pixel   = pane:tab():get_size().pixel_width / pane:tab():get_size().cols
    local window_width      = window:get_dimensions().pixel_width
    local min_window_width  = min_window_columns * column_to_pixel
    local padding           = math.min( window_width / 4, ( window_width - min_window_width ) / 2 )

    if padding < 0 then
      padding = nil
    end

    if      not overrides.window_padding then
      overrides.window_padding = default_window_padding
    elseif  overrides.window_padding.left == padding or
            overrides.window_padding.right == padding then
      padding = nil
    end

    overrides.window_padding.left   = padding
    overrides.window_padding.right  = padding
    window:set_config_overrides( overrides )

  end
)

wezterm.on( toggleInternalTerminalEvent,
  function( window, pane )

    local overrides = window:get_config_overrides() or {}

    if not overrides.leader then

      overrides.enable_tab_bar  = false
      overrides.leader          =
        {
          key   = '_',
          mods  = 'WIN|CTRL|SHIFT|ALT',
        }
      overrides.keys            =
        {
          { key = 'F10',  action = act.DisableDefaultAssignment                 },
          { key = 'F9',   action = act.EmitEvent( toggleInternalTerminalEvent ) },
        }

    else

      overrides.enable_tab_bar  = nil
      overrides.leader          = nil
      overrides.keys            = nil

    end

    window:set_config_overrides( overrides )

  end
)
return config
