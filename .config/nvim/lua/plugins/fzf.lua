return {
	"nvim-telescope/telescope.nvim",
	cmd = "Telescope",
	config = function()
		local actions = require("telescope.actions")
		require("telescope").setup({
			defaults = {
				mappings = {
					i = {
						["<C-h>"] = actions.select_horizontal,
					},
					n = {
						["<C-c>"] = actions.close,
						["<C-h>"] = actions.select_horizontal,
					},
				},
			},
		})
	end,
}
