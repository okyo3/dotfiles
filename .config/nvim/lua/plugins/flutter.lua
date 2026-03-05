return {
	"akinsho/flutter-tools.nvim",
	dependencies = {
		"nvim-lua/plenary.nvim",
		"stevearc/dressing.nvim",
	},
	config = function()
		require("flutter-tools").setup({
			ui = {
				border = "rounded",
			},
			decorations = {
				statusline = {
					app_version = true,
					device = true,
				},
			},
			dev_log = {
				enabled = true,
			},
			dev_tools = {
				autostart = true,
			},
			lsp = {
				color = {
					enabled = true,
				},
			},
		})
	end,
}
