local wezterm = require("wezterm")
local config = {}

wezterm.on("toggle_opacity", function(window)
	local overrides = window:get_config_overrides() or {}
	if overrides.window_background_opacity == 0.95 then
		overrides.window_background_opacity = 0.5
		overrides.macos_window_background_blur = 0
	else
		overrides.window_background_opacity = 0.95
		overrides.macos_window_background_blur = 15
	end
	window:set_config_overrides(overrides)
end)

config.adjust_window_size_when_changing_font_size = false
config.check_for_updates = false
config.initial_cols = 155
config.initial_rows = 45
config.hyperlink_rules = {
	{
		regex = "\\b\\w+://[\\w.-]+:[0-9]{2,15}\\S*\\b",
		format = "$0",
	},
	{
		regex = "\\b\\w+://[\\w.-]+\\.[a-z]{2,15}\\S*\\b",
		format = "$0",
	},
	{
		regex = [[\b\w+@[\w-]+(\.[\w-]+)+\b]],
		format = "mailto:$0",
	},
	{
		regex = [[\bfile://\S*\b]],
		format = "$0",
	},
	{
		regex = [[\b\w+://(?:[\d]{1,3}\.){3}[\d]{1,3}\S*\b]],
		format = "$0",
	},
	{
		regex = [[\b[tT](\d+)\b]],
		format = "https://example.com/tasks/?t=$1",
	},
}
config.mouse_wheel_scrolls_tabs = false
config.show_update_window = false
config.warn_about_missing_glyphs = false
config.window_close_confirmation = "NeverPrompt"

config.disable_default_key_bindings = true
config.leader = { key = "l", mods = "CTRL" }
config.keys = {
	-- with leader key
	{ key = "t", mods = "LEADER", action = wezterm.action({ SpawnTab = "CurrentPaneDomain" }) },
	{ key = "h", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Left" }) },
	{ key = "j", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Down" }) },
	{ key = "k", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Up" }) },
	{ key = "l", mods = "LEADER", action = wezterm.action({ ActivatePaneDirection = "Right" }) },
	{ key = "n", mods = "LEADER", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "m", mods = "LEADER", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "d", mods = "LEADER", action = wezterm.action({ CloseCurrentPane = { confirm = true } }) },
	{ key = "w", mods = "LEADER", action = wezterm.action({ CloseCurrentTab = { confirm = true } }) },
	{ key = "f", mods = "LEADER", action = wezterm.action.ToggleFullScreen },
	{ key = "q", mods = "LEADER", action = wezterm.action.QuitApplication },
	{ key = "p", mods = "LEADER", action = wezterm.action.ActivateCommandPalette },
	{ key = "o", mods = "LEADER", action = wezterm.action.EmitEvent("toggle_opacity") },
	{ key = "=", mods = "LEADER", action = wezterm.action.IncreaseFontSize },
	{ key = "-", mods = "LEADER", action = wezterm.action.DecreaseFontSize },
	{ key = "N", mods = "LEADER|SHIFT", action = wezterm.action.SpawnWindow },
	{
		key = "V",
		mods = "LEADER|SHIFT",
		action = wezterm.action({ SplitHorizontal = { domain = "CurrentPaneDomain" } }),
	},
	{ key = "H", mods = "LEADER|SHIFT", action = wezterm.action({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
	{ key = "s", mods = "LEADER|CTRL", action = wezterm.action.QuickSelect },
	{ key = "c", mods = "LEADER|CTRL", action = wezterm.action.ActivateCopyMode },
	{ key = "v", mods = "LEADER|CTRL", action = wezterm.action.PasteFrom("Clipboard") },
	{
		key = "n",
		mods = "LEADER|CTRL",
		action = wezterm.action.PromptInputLine({
			description = "(wezterm) Create new workspace:",
			action = wezterm.action_callback(function(window, pane, line)
				if line then
					window:perform_action(
						wezterm.action.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},
	{
		key = "w",
		mods = "LEADER|CTRL",
		action = wezterm.action_callback(function(win, pane)
			local workspaces = {}
			for i, name in ipairs(wezterm.mux.get_workspace_names()) do
				table.insert(workspaces, {
					id = name,
					label = string.format("%d. %s", i, name),
				})
			end
			win:perform_action(
				wezterm.action.InputSelector({
					action = wezterm.action_callback(function(_, _, id, label)
						if not id and not label then
							wezterm.log_info("Workspace selection canceled")
						else
							win:perform_action(wezterm.action.SwitchToWorkspace({ name = id }), pane)
						end
					end),
					title = "Select workspace",
					choices = workspaces,
					fuzzy = true,
				}),
				pane
			)
		end),
	},
	-- without leader key
	{ key = "n", mods = "ALT", action = wezterm.action.ActivateTabRelative(-1) },
	{ key = "m", mods = "ALT", action = wezterm.action.ActivateTabRelative(1) },
	{ key = "-", mods = "ALT", action = wezterm.action.DecreaseFontSize },
	{ key = "=", mods = "ALT", action = wezterm.action.IncreaseFontSize },
	{ key = "h", mods = "ALT", action = wezterm.action({ AdjustPaneSize = { "Left", 5 } }) },
	{ key = "j", mods = "ALT", action = wezterm.action({ AdjustPaneSize = { "Down", 5 } }) },
	{ key = "k", mods = "ALT", action = wezterm.action({ AdjustPaneSize = { "Up", 5 } }) },
	{ key = "l", mods = "ALT", action = wezterm.action({ AdjustPaneSize = { "Right", 5 } }) },
}

config.show_tabs_in_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false
config.tab_bar_at_bottom = true
config.tab_max_width = 50

config.show_new_tab_button_in_tab_bar = false
-- config.show_close_tab_button_in_tabs = false

config.colors = {
	tab_bar = {
		inactive_tab_edge = "none",
	},
}

local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_left_half_circle_thick
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_right_half_circle_thick
wezterm.on("format-tab-title", function(tab, _, _, _, _, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"
	local edge_background = "none"
	if tab.is_active then
		background = "#13a6a8"
		foreground = "#FFFFFF"
	end
	local edge_foreground = background
	local title = " " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. " "
	return {
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_LEFT_ARROW },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
	}
end)

config.command_palette_bg_color = "#00001d"
config.command_palette_fg_color = "#008888"
config.command_palette_rows = 24
config.enable_scroll_bar = false
config.font_size = 11.5
config.inactive_pane_hsb = {
	hue = 1.0,
	saturation = 1.5,
	brightness = 0.3,
}
config.integrated_title_button_alignment = "Right"
config.window_background_gradient = {
	colors = {
		"#000015",
	},
}
config.window_background_opacity = 0.95
config.macos_window_background_blur = 15
config.window_decorations = "RESIZE"
config.window_frame = {
	inactive_titlebar_bg = "none",
	active_titlebar_bg = "none",
	border_left_width = "1cell",
	border_right_width = "1cell",
	border_bottom_height = "0.75cell",
}
config.window_padding = {
	left = 23,
	right = 23,
	top = 23,
	bottom = 23,
}

return config
