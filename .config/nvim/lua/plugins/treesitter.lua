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
				local lang = vim.treesitter.language.get_lang(ft) or ft

				if not pcall(vim.treesitter.language.add, lang) then
					return
				end

				local ok = pcall(vim.treesitter.start, args.buf, lang)
				if not ok then
					return
				end

				vim.bo[args.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

				vim.wo[0].foldmethod = "expr"
				vim.wo[0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[0].foldlevel = 99
			end,
		})
	end,
}
