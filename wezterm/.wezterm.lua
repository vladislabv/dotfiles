local wezterm = require 'wezterm'

local config = {}
if wezterm.config_builder then
  config = wezterm.config_builder()
end

config.default_domain = 'WSL:NixOS'
config.default_cwd = 'wsl:///NixOS/home/vstasenko'

config.color_scheme = 'Catppuccin Mocha'
config.font = wezterm.font('JetBrains Mono')
config.font_size = 11.0
config.window_background_opacity = 0.95
config.window_decorations = 'TITLE | RESIZE'
config.hide_tab_bar_if_only_one_tab = true
config.scrollback_lines = 10000

config.keys = {
  { key = 'd',        mods = 'CTRL|SHIFT',      action = wezterm.action.SplitVertical   { domain = 'CurrentPaneDomain' } },
  { key = 'd',        mods = 'CTRL|SHIFT|ALT',  action = wezterm.action.SplitHorizontal { domain = 'CurrentPaneDomain' } },
  { key = 't',        mods = 'CTRL|SHIFT',      action = wezterm.action.SpawnTab        'CurrentPaneDomain' },
  { key = 'w',        mods = 'CTRL|SHIFT',      action = wezterm.action.CloseCurrentTab { confirm = true } },
  { key = 'h',        mods = 'CTRL|SHIFT',      action = wezterm.action.ActivatePaneDirection 'Left'  },
  { key = 'l',        mods = 'CTRL|SHIFT',      action = wezterm.action.ActivatePaneDirection 'Right' },
  { key = 'k',        mods = 'CTRL|SHIFT',      action = wezterm.action.ActivatePaneDirection 'Up'    },
  { key = 'j',        mods = 'CTRL|SHIFT',      action = wezterm.action.ActivatePaneDirection 'Down'  },
  { key = 'PageUp',   mods = 'SHIFT',           action = wezterm.action.ScrollByPage(-1) },
  { key = 'PageDown', mods = 'SHIFT',           action = wezterm.action.ScrollByPage(1) },
}

return config
