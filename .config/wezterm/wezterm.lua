local wezterm = require 'wezterm'
local config = {}

function get_appearance()
  if wezterm.gui then
    return wezterm.gui.get_appearance()
  end
  return 'Dark'
end

function scheme_for_appearance()
  if get_appearance():find 'Dark' then
    return 'Catppuccin Mocha'
  else
    return 'Catppuccin Latte'
  end
end

config.initial_cols = 120
config.initial_rows = 66
config.window_close_confirmation = 'NeverPrompt'
config.window_background_opacity = 0.95
config.tab_bar_at_bottom = true
config.color_scheme = scheme_for_appearance()
config.font_size = 12.0
config.font = wezterm.font_with_fallback {
  'UbuntuMono Nerd Font',
  'Ubuntu Mono',
  'Hiragino Sans',
}

return config
