return {
	{
		"lewis6991/gitsigns.nvim",
		event = { "BufReadPre", "BufNewFile" },
		opts = {
			current_line_blame_formatter = "<author>, <author_time:%Y-%m-%d> - <summary> (<abbrev_sha>)",
		},
	},
}
