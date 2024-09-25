-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Aura (Gogh)"

config.font = wezterm.font("JetBrains Mono")

config.window_background_opacity = 0.7

-- key bindings
--
-- timeout_milliseconds defaults to 1000 and can be omitted
config.leader = { key = "q", mods = "CTRL", timeout_milliseconds = 1000 }

config.keys = {
	-- Windows
	--
	-- SpawnTab
	-- Create window
	{
		key = "c",
		mods = "LEADER",
		action = wezterm.action.SpawnTab("DefaultDomain"),
	},
	-- CloseCurrentTab
	-- Close current window
	{
		-- CTRL-a, followed by SHIFT-& will close current window
		key = "&",
		mods = "LEADER|SHIFT",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
	},
	-- ActivateTabRelative
	-- Previous window
	{
		key = "p",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(-1),
	},
	-- Next window
	{
		key = "n",
		mods = "LEADER",
		action = wezterm.action.ActivateTabRelative(1),
	},
	-- ActivateTab
	-- Switch/select window by number
	{
		key = "F1",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(0),
	},
	{
		key = "F2",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(1),
	},
	{
		key = "F3",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(2),
	},
	{
		key = "F4",
		mods = "LEADER",
		action = wezterm.action.ActivateTab(3),
	},
	--
	-- Panes
	--
	-- SplitHorizontal
	-- Split the current pane with a vertical line to create a horizontal layout
	{
		key = "%",
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	-- SplitVertical
	-- Split the current with a horizontal line to create a vertical layout
	{
		key = '"',
		mods = "LEADER|SHIFT",
		action = wezterm.action.SplitVertical({ domain = "CurrentPaneDomain" }),
	},
	-- ActivatePaneDirection
	-- Switch to pane to the direction
	{
		key = "LeftArrow",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "RightArrow",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "UpArrow",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "DownArrow",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	-- ActivatePaneByIndex
	-- Switch/select pane by number
	{
		key = "0",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneByIndex(0),
	},
	{
		key = "1",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneByIndex(1),
	},
	{
		key = "2",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneByIndex(2),
	},
	{
		key = "3",
		mods = "LEADER",
		action = wezterm.action.ActivatePaneByIndex(3),
	},
	-- TogglePaneZoomState
	-- Toggle pane zoom
	{
		key = "z",
		mods = "LEADER",
		action = wezterm.action.TogglePaneZoomState,
	},
	-- AdjustPaneSize
	-- Resize current pane width(holding second key is optional)
	{
		key = "LeftArrow",
		mods = "LEADER|CTRL",
		action = wezterm.action.AdjustPaneSize({ "Left", 5 }),
	},
	{
		key = "RightArrow",
		mods = "LEADER|CTRL",
		action = wezterm.action.AdjustPaneSize({ "Right", 5 }),
	},
	-- Resize current pane height(holding second key is optional)
	{
		key = "UpArrow",
		mods = "LEADER|CTRL",
		action = wezterm.action.AdjustPaneSize({ "Up", 5 }),
	},
	{
		key = "DownArrow",
		mods = "LEADER|CTRL",
		action = wezterm.action.AdjustPaneSize({ "Down", 5 }),
	},

	-- CloseCurrentPane
	-- Close current pane
	{
		key = "x",
		mods = "LEADER",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
}

-- and finally, return the configuration to wezterm
return config