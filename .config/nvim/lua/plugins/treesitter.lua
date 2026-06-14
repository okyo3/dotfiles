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
			"gomod",
			"gosum",
			"gowork",
		},
		auto_install = true,
	},
	config = function(_, opts)
		local install_dir = vim.fn.stdpath("data") .. "/site"
		local plugin_runtime = vim.fn.stdpath("data") .. "/lazy/nvim-treesitter/runtime"
		if not vim.tbl_contains(vim.opt.runtimepath:get(), plugin_runtime) then
			vim.opt.runtimepath:append(plugin_runtime)
		end

		opts = vim.tbl_deep_extend("force", opts, {
			install_dir = install_dir,
		})

		local treesitter = require("nvim-treesitter")
		treesitter.setup(opts)

		local installed = treesitter.get_installed()
		local missing = vim.tbl_filter(function(lang)
			return not vim.list_contains(installed, lang)
		end, opts.ensure_installed or {})
		if #missing > 0 then
			treesitter.install(missing)
		end

		local function enable_treesitter(bufnr)
			if not vim.api.nvim_buf_is_valid(bufnr) then
				return
			end

			local ft = vim.bo[bufnr].filetype
			if ft == "" or vim.bo[bufnr].buftype ~= "" then
				return
			end

			local lang = vim.treesitter.language.get_lang(ft) or ft
			if not pcall(vim.treesitter.language.add, lang) then
				return
			end

			if not pcall(vim.treesitter.start, bufnr, lang) then
				return
			end

			vim.bo[bufnr].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

			local winid = vim.fn.bufwinid(bufnr)
			if winid ~= -1 then
				vim.wo[winid].foldmethod = "expr"
				vim.wo[winid].foldexpr = "v:lua.vim.treesitter.foldexpr()"
				vim.wo[winid].foldlevel = 99
			end
		end

		local group = vim.api.nvim_create_augroup("MyTreesitterSetup", { clear = true })
		vim.api.nvim_create_autocmd({ "FileType", "BufEnter" }, {
			group = group,
			pattern = "*",
			callback = function(args)
				enable_treesitter(args.buf)
			end,
		})

		for _, bufnr in ipairs(vim.api.nvim_list_bufs()) do
			enable_treesitter(bufnr)
		end
	end,
}
