vim.api.nvim_create_autocmd("ColorScheme", {
	pattern = "*",
	callback = function()
		local groups = {
			"StatusLine", "StatusLineNC",
			"WinBar", "WinBarNC",
			"CursorLine", "CursorColumn",
			"NavicText", "NavicSeparator",
		}
		for _, group in ipairs(groups) do
			local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = group })
			if ok then
				hl.bg = nil
				vim.api.nvim_set_hl(0, group, hl)
			end
		end
	end,
})

vim.api.nvim_create_autocmd("FileType", {
	pattern = "go",

	callback = function()
		vim.opt_local.tabstop = 4
		vim.opt_local.softtabstop = 4
		vim.opt_local.shiftwidth = 4
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
