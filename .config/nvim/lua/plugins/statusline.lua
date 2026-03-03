return {
	"nvim-lualine/lualine.nvim",
	config = function()
		local colors = {
			blue1 = "#010b19",
			blue2 = "#021631",
			blue3 = "#03214a",
			blue4 = "#042c62",
			blue5 = "#05377b",
			normal = "#00aaaa",
			insert = "#6de946",
			visual = "#dc95fd",
			replace = "#e4757b",
		}

		local function custom_file_path()
			local filepath = vim.fn.expand("%:p")
			if filepath == "" then
				return ""
			end
			local git_root = vim.fs.find(".git", {
				path = vim.fn.expand("%:p:h"),
				upward = true,
			})[1]
			if git_root then
				git_root = vim.fn.fnamemodify(git_root, ":h")
				return vim.fn.fnamemodify(filepath, ":." .. git_root)
			end
			return vim.fn.fnamemodify(filepath, ":~")
		end

		local custom = {
			normal = {
				a = { fg = colors.normal, bg = colors.blue2 },
				b = { fg = colors.text, bg = colors.blue3 },
				c = { fg = colors.text },
			},
			insert = { a = { fg = colors.insert, bg = colors.blue2 } },
			visual = { a = { fg = colors.visual, bg = colors.blue2 } },
			replace = { a = { fg = colors.replace, bg = colors.blue2 } },

			inactive = {
				a = { fg = colors.text, bg = colors.blue2 },
				b = { fg = colors.text, bg = colors.blac3 },
				c = { fg = colors.text },
			},
		}

		require("lualine").setup({
			options = {
				theme = custom,
				section_separators = { left = "", right = "" },
			},
			sections = {
				lualine_a = { { "mode", right_padding = 2 } },
				lualine_b = { custom_file_path },
				lualine_c = { "branch", "diff", "diagnostics" },
				lualine_x = {},
				lualine_y = { "filetype" },
				lualine_z = { { "location", left_padding = 2 } },
			},
			inactive_sections = {
				lualine_a = { custom_file_path },
				lualine_b = {},
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = { { "filetype", left_padding = 2 } },
			},
		})
		require("lualine").setup({})
	end,
}
