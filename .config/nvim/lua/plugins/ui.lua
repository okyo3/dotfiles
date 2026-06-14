return {
	-------------------------------------------------
	-- LSP Progress UI
	-------------------------------------------------
	{
		"j-hui/fidget.nvim",
		opts = {},
	},

	-------------------------------------------------
	-- Colorizer
	-------------------------------------------------
	{
		"NvChad/nvim-colorizer.lua",
		config = function()
			require("colorizer").setup()
		end,
	},

	-------------------------------------------------
	-- Diffview
	-------------------------------------------------
	{
		"sindrets/diffview.nvim",
		cmd = { "DiffviewOpen" },
		opts = {
			default_args = {
				DiffviewOpen = { "--imply-local" },
			},
		},
	},
	{
		"folke/todo-comments.nvim",
		dependencies = { "nvim-lua/plenary.nvim" },
		opts = {
			-- your configuration comes here
			-- or leave it empty to use the default settings
			-- refer to the configuration section below
		},
	},
}
