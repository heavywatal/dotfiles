local wezterm = require 'wezterm'
local config = {}

config.check_for_updates = false
config.window_close_confirmation = 'NeverPrompt'
config.bypass_mouse_reporting_modifiers = 'CMD'

config.font_size = 12.0
config.font = wezterm.font_with_fallback {
  'UbuntuMono Nerd Font',
  'Ubuntu Mono',
  { family = 'Menlo', scale = 0.84 },
  'Hiragino Sans',
  'Apple Color Emoji',
}
config.initial_cols = 120
config.initial_rows = 85
config.show_tab_index_in_tab_bar = false
config.tab_bar_at_bottom = false
config.tab_max_width = 32
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"

config.default_cursor_style = 'BlinkingBlock'
config.cursor_blink_rate = 500
config.cursor_blink_ease_in = 'Constant'
config.cursor_blink_ease_out = 'Constant'

function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function modify_alpha(color, alpha)
  r, g, b, a = wezterm.color.parse(color):srgba_u8()
  return string.format("rgba(%d %d %d %f)", r, g, b, alpha)
end

config.color_scheme = 'Selenized White (Gogh)'
local scheme_toml = 'selenized-white.toml'
local ui_bg = '#f2f2f2'
if get_appearance():find 'Dark' then
  config.color_scheme = 'Selenized Black (Gogh)'
  scheme_toml = 'selenized-black.toml'
  ui_bg = '#3a3a3a'
end
local colors, metadata = wezterm.color.load_scheme(wezterm.config_dir .. '/colors/' .. scheme_toml)
local fg = colors.foreground
local bg = colors.background

config.window_background_opacity = 0.95
config.window_frame = {
  font = wezterm.font_with_fallback {
    'SF Pro',
    'Helvetica Neue',
    'Ubuntu',
  },
  font_size = 13,
  active_titlebar_bg = modify_alpha(ui_bg, config.window_background_opacity),
  inactive_titlebar_bg = modify_alpha(ui_bg, 0.90),
}
config.colors = {
  tab_bar = {
    inactive_tab_edge = 'none',
    active_tab = {
      bg_color = bg,
      fg_color = fg,
    },
    inactive_tab = {
      bg_color = modify_alpha(bg, 0.4),
      fg_color = fg,
    },
    inactive_tab_hover = {
      bg_color = modify_alpha(bg, 0.8),
      fg_color = fg,
    },
    new_tab = {
      bg_color = 'none',
      fg_color = fg,
    },
    new_tab_hover = {
      bg_color = modify_alpha(bg, 0.8),
      fg_color = fg,
    },
  },
}
config.keys = {
  {
    key = 't',
    mods = 'CMD',
    action = wezterm.action.SpawnCommandInNewTab {
      cwd = wezterm.home_dir,
    },
  },
}

return config
