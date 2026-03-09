return {
	"nvim-treesitter/nvim-treesitter",
	branch = "main",
	build = ":TSUpdate",
	opts = {
		ensure_installed = {
			"lua",
			"vim",
			"vimdoc",
			"bash",
			"json",
			"javascript",
			"typescript",
			"dart",
			"go",
		},
		auto_install = true,
	},
	config = function(_, opts)
		require("nvim-treesitter").setup(opts)

		local group = vim.api.nvim_create_augroup("MyTreesitterSetup", { clear = true })
		vim.api.nvim_create_autocmd("FileType", {
			group = group,
			pattern = "*",
			callback = function(args)
				local ft = vim.bo[args.buf].filetype
				-- filetype に対応するパーサー名を取得（なければ filetype をそのまま使う）
				local lang = vim.treesitter.language.get_lang(ft) or ft

				-- パーサーが利用可能かチェック
				if not pcall(vim.treesitter.language.add, lang) then
					return
				end

				-- ハイライトを有効にする
				vim.treesitter.start(args.buf, lang)

				-- インデントを有効にする
				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"
			end,
		})
	end,
}
