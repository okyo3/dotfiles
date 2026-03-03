return {
	"goolord/alpha-nvim",
	dependencies = { "MaximilianLloyd/ascii.nvim" },
	config = function()
		require("alpha").setup(require("alpha.themes.dashboard").config)
		local dashboard = require("alpha.themes.dashboard")
		dashboard.section.header.val = require("ascii").art.text.neovim.sharp
		dashboard.section.buttons.val = {
			dashboard.button("q", "󰅚  Quit NVIM", ":qa<CR>"),
			dashboard.button("e", "  View dir", ":Neotree float<CR>"),
			dashboard.button("f", "  Find file", ":Telescope find_files hidden=true<CR>"),
			dashboard.button("g", "  Live grep", ":Telescope live_grep<CR>"),
			dashboard.button("h", "󰋖  Find help", ":Telescope help_tags<CR>"),
			dashboard.button("K", "  Find keymap", ":Telescope keymaps<CR>"),
			dashboard.button("G", "  Lazy git", ":lua _lazygit_toggle()<CR>"),
			dashboard.button("l", "  Check lsp", ":Mason<CR>"),
			dashboard.button("t", "  Toggle terminal", ":ToggleTerm direction=float<CR>"),
		}
	end,
}
