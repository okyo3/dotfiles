return {
	-------------------------------------------------
	-- Transparent
	-------------------------------------------------
	{
		"xiyaowong/transparent.nvim",
		config = function()
			require("transparent").setup()
		end,
	},

	-------------------------------------------------
	-- LSP Progress UI
	-------------------------------------------------
	{
		"j-hui/fidget.nvim",
		opts = {},
	},

	-------------------------------------------------
	-- Scrollbar
	-------------------------------------------------
	{
		"petertriho/nvim-scrollbar",
		dependencies = "lewis6991/gitsigns.nvim",
		config = function()
			require("scrollbar").setup({})
		end,
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
	-- Navbuddy (LSP UI)
	-------------------------------------------------
	{
		"SmiteshP/nvim-navbuddy",
		dependencies = {
			"SmiteshP/nvim-navic",
			"MunifTanjim/nui.nvim",
		},
		config = function()
			require("nvim-navbuddy").setup({
				window = {
					size = { height = "40%", width = "100%" },
					position = { row = "100%", col = "50%" },
				},
				lsp = { auto_attach = true },
			})
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

	-------------------------------------------------
	-- Swagger Preview
	-------------------------------------------------
	{
		"vinnymeller/swagger-preview.nvim",
		config = function()
			require("swagger-preview").setup({
				port = 8003,
				host = "localhost",
			})
		end,
	},
	{
		"folke/noice.nvim",
		event = "VeryLazy",
		opts = {
			-- add any options here
		},
		dependencies = {
			-- if you lazy-load any plugin below, make sure to add proper `module="..."` entries
			"MunifTanjim/nui.nvim",
			-- OPTIONAL:
			--   `nvim-notify` is only needed, if you want to use the notification view.
			--   If not available, we use `mini` as the fallback
			"rcarriga/nvim-notify",
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
	{
		"shellRaining/hlchunk.nvim",
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("hlchunk").setup({})
		end,
	},
	{
		"monaqa/dial.nvim",
		event = "VeryLazy",
		config = function()
			local dial = require("dial.map")
			vim.keymap.set("n", "<C-a>", dial.inc_normal(), { noremap = true })
			vim.keymap.set("n", "<C-x>", dial.dec_normal(), { noremap = true })
			vim.keymap.set("v", "<C-a>", dial.inc_visual(), { noremap = true })
			vim.keymap.set("v", "<C-x>", dial.dec_visual(), { noremap = true })
		end,
	},
}
