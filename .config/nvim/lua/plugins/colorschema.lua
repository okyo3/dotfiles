return {
	{
		"folke/tokyonight.nvim",
		config = function()
			require("tokyonight").setup({
				transparent = true,
				styles = {
					sidebars = "transparent",
					floats = "transparent",
				},
			})
			vim.cmd([[colorscheme tokyonight-night]])
		end,
	},
	-- {
	-- 	"catppuccin/nvim",
	-- 	name = "catppuccin",
	-- 	priority = 1000,
	-- 	config = function()
	-- 		require("catppuccin").setup({
	-- 			flavour = "mocha", -- latte / frappe / macchiato / mocha
	-- 			transparent_background = true, -- ← 透過ON
	-- 			term_colors = true,
	--
	-- 			integrations = {
	-- 				cmp = true,
	-- 				gitsigns = true,
	-- 				telescope = true,
	-- 				treesitter = true,
	-- 				notify = true,
	-- 				mini = true,
	-- 			},
	--
	-- 			custom_highlights = function(colors)
	-- 				return {
	-- 					-- 完全透過
	-- 					Normal = { bg = "NONE" },
	-- 					NormalFloat = { bg = "NONE" },
	-- 					SignColumn = { bg = "NONE" },
	-- 					EndOfBuffer = { bg = "NONE" },
	--
	-- 					-- 分割線だけ少し主張
	-- 					WinSeparator = { fg = colors.overlay0 },
	--
	-- 					-- フロート枠
	-- 					FloatBorder = { fg = colors.overlay1, bg = "NONE" },
	-- 				}
	-- 			end,
	-- 		})
	--
	-- 		vim.cmd("colorscheme catppuccin")
	-- 	end,
	-- },
}
