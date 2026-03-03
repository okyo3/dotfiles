return {
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = {
					enabled = true,
					auto_trigger = true,
					keymap = {
						accept = false,
					},
				},
				panel = {
					enabled = false,
				},
				filetypes = {
					markdown = true,
					["."] = false,
				},
			})
		end,
	},
	{
		"CopilotC-Nvim/CopilotChat.nvim",
		branch = "main",
		build = "make tiktoken",
		opts = {
			window = {
				layout = "vertical",
				width = 0.35,
				border = "rounded",
			},
			show_help = false,
			show_folds = false,
			highlights = {
				user = "Identifier",
				assistant = "Statement",
			},
		},
	},
}
