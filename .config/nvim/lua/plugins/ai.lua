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
						accept = "<Tab>",
						dissmiss = "<S-Tab>",
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
			language = "Japanese",
			trusted_tools = { "buffer", "file", "glob", "grep", "gitdiff", "edit" },
			chat_autocomplete = false,
			window = {
				layout = "vertical",
				width = 0.35,
				border = "rounded",
			},
			auto_insert_mode = true,
			show_help = false,
			show_folds = false,
			highlights = {
				user = "Identifier",
				assistant = "Statement",
			},
			prompts = {
				Agent = {
					description = "Workspace coding agent",
					tools = "copilot",
					trusted_tools = { "buffer", "file", "glob", "grep", "gitdiff", "edit" },
					prompt = table.concat({
						"このワークスペースのコーディングエージェントとして振る舞ってください.",
						"必要なときだけ tools を使って関連ファイルや差分を確認し、根拠に基づいて答えてください.",
						"buffer, file, glob, grep, gitdiff, edit は必要に応じて自律的に使って構いません.",
						"bash は必要な場合のみ提案し、承認が必要な前提で扱ってください.",
						"編集が必要なら最小限の変更を優先してください.",
						"回答は日本語で簡潔にし、結果と次の一手を明確にしてください.",
					}, " "),
				},
			},
		},
	},
}
