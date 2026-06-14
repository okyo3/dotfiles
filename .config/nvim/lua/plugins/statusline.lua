return {
	"nvim-lualine/lualine.nvim",
	config = function()
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

		require("lualine").setup({
			options = {
				theme = "auto",
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
	end,
}
