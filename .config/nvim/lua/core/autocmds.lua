vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",

	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client or client.name ~= "gopls" then
			return
		end

		vim.api.nvim_create_autocmd("BufWritePre", {
			buffer = args.buf,
			group = vim.api.nvim_create_augroup("GoFormatOnSave", { clear = false }),
			callback = function()
				vim.lsp.buf.format({
					bufnr = args.buf,
					id = client.id,
					async = false,
					timeout_ms = 2000,
				})
			end,
		})
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "py",
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "lua",
	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
	end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
	callback = function()
		if vim.bo.modified and vim.bo.buftype == "" then
			vim.cmd("silent write")
		end
	end,
})
