-- Pull in the wezterm API
local wezterm = require 'wezterm'
local act = wezterm.action

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices.

-- For example, changing the initial geometry for new windows:
config.initial_cols = 120
config.initial_rows = 28

config.cursor_blink_rate = 250

-- or, changing the font size and color scheme.
config.font = wezterm.font_with_fallback({'JetBrains Mono', 'Symbols Nerd Font Mono'})
-- config.font = wezterm.font_with_fallback({"MonoLisaCode Trial", "Symbols Nerd Font Mono"})
-- config.font = wezterm.font_with_fallback({"Departure Mono", "Symbols Nerd Font Mono"})
config.font_size = 12
config.color_scheme = 'nordfox'
-- config.color_scheme = 'Catppuccin Frappe'

config.window_background_opacity = 0.96

config.hide_tab_bar_if_only_one_tab = true

--[[
config.window_background_gradient = {
  -- Can be "Vertical" or "Horizontal".  Specifies the direction
  -- in which the color gradient varies.  The default is "Horizontal",
  -- with the gradient going from left-to-right.
  -- Linear and Radial gradients are also supported; see the other
  -- examples below
  orientation = 'Vertical',

  -- Specifies the set of colors that are interpolated in the gradient.
  -- Accepts CSS style color specs, from named colors, through rgb
  -- strings and more
  colors = {
    '#88c0d0',
    '#a3be8c',
    '#3b4252',
  },

  -- Instead of specifying `colors`, you can use one of a number of
  -- predefined, preset gradients.
  -- A list of presets is shown in a section below.
  -- preset = "Warm",

  -- Specifies the interpolation style to be used.
  -- "Linear", "Basis" and "CatmullRom" as supported.
  -- The default is "Linear".
  interpolation = 'Linear',

  -- How the colors are blended in the gradient.
  -- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
  -- The default is "Rgb".
  blend = 'Rgb',

  -- To avoid vertical color banding for horizontal gradients, the
  -- gradient position is randomly shifted by up to the `noise` value
  -- for each pixel.
  -- Smaller values, or 0, will make bands more prominent.
  -- The default value is 64 which gives decent looking results
  -- on a retina macbook pro display.
  -- noise = 64,

  -- By default, the gradient smoothly transitions between the colors.
  -- You can adjust the sharpness by specifying the segment_size and
  -- segment_smoothness parameters.
  -- segment_size configures how many segments are present.
  -- segment_smoothness is how hard the edge is; 0.0 is a hard edge,
  -- 1.0 is a soft edge.

  -- segment_size = 11,
  -- segment_smoothness = 0.0,
}
--]]

config.keys = {
    {
        key = 'LeftArrow',
        mods = 'OPT',
        action = act.SendKey {
            key = 'b',
            mods = 'ALT',
        },
    },
    {
        key = 'RightArrow',
        mods = 'OPT',
        action = act.SendKey {
            key = 'f',
            mods = 'ALT'
        }
    },
    {
        key = 'LeftArrow',
        mods = 'CMD',
        action = act.ActivatePaneDirection 'Left'
    },
    {
        key = 'RightArrow',
        mods = 'CMD',
        action = act.ActivatePaneDirection 'Right'
    },
    {
        key = 'UpArrow',
        mods = 'CMD',
        action = act.ActivatePaneDirection 'Up'
    },
    {
        key = 'DownArrow',
        mods = 'CMD',
        action = act.ActivatePaneDirection 'Down'
    },
    {
        key = '1',
        mods = 'CMD',
        action = act.TogglePaneZoomState
    }
}

-- Finally, return the configuration to wezterm:
return config

