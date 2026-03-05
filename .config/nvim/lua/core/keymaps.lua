-------------------------------------------------
-- Leader
-------------------------------------------------
vim.g.mapleader = " "

local map = vim.keymap.set

-------------------------------------------------
-- General
-------------------------------------------------
map("n", "<leader><C-a>", "gg<S-v>G", { silent = true, desc = "Select all" })
map("n", "Y", "y$", { silent = true, desc = "Yank to end of line" })

map("i", "jk", "<ESC>", { silent = true })
map("i", "JK", "<ESC>", { silent = true })
map("i", "jK", "<ESC>", { silent = true })
map("i", "Jk", "<ESC>", { silent = true })

-- quote textobject
for _, quote in ipairs({ '"', "'", "`" }) do
	map({ "x", "o" }, "a" .. quote, "2i" .. quote)
end

-------------------------------------------------
-- LSP (buffer local)
-------------------------------------------------
vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(event)
		local opts = { buffer = event.buf, silent = true }
		map("n", "gk", "<cmd>Lspsaga hover_doc<CR>", opts)
		map("n", "gd", "<cmd>Lspsaga peek_definition<CR>", opts)
		map("n", "gD", "<cmd>Lspsaga goto_definition<CR>", opts)
		map("n", "gi", "<cmd>Lspsaga implementation<CR>", opts)
		map("n", "gr", "<cmd>Lspsaga finder<CR>", opts)
		map("n", "ga", "<cmd>Lspsaga code_action<CR>", opts)
		map("n", "gh", "<cmd>Lspsaga rename<CR>", opts)
		map("n", "ge", "<cmd>Lspsaga show_line_diagnostics<CR>", opts)
		map("n", "gf", function()
			vim.lsp.buf.format({ async = true })
		end, opts)
	end,
})

-------------------------------------------------
-- BufferLine
-------------------------------------------------
map("n", "<leader>bp", "<cmd>BufferLinePick<CR>", { silent = true, desc = "Pick buffer" })
map("n", "<leader>bc", "<cmd>BufferLinePickClose<CR>", { silent = true, desc = "Pick & close buffer" })
map("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { silent = true, desc = "Close other buffers" })
map("n", "<C-m>", "<cmd>BufferLineCycleNext<CR>", { silent = true, desc = "Next buffer" })
map("n", "<C-n>", "<cmd>BufferLineCyclePrev<CR>", { silent = true, desc = "Previous buffer" })

-------------------------------------------------
-- Neo-tree
-------------------------------------------------
map("n", "<leader>e", "<cmd>Neotree float<CR>", { silent = true, desc = "Explorer (float)" })
map("n", "<leader>b", "<cmd>Neotree float buffers<CR>", { silent = true, desc = "Buffers (float)" })

-------------------------------------------------
-- Telescope
-------------------------------------------------
map("n", "<leader>ff", "<cmd>Telescope find_files hidden=true<CR>", { silent = true, desc = "Find files" })
map("n", "<leader>fl", "<cmd>Telescope live_grep<CR>", { silent = true, desc = "Live grep" })
map("n", "<leader>fh", "<cmd>Telescope help_tags<CR>", { silent = true, desc = "Help tags" })
map("n", "<leader>fk", "<cmd>Telescope keymaps<CR>", { silent = true, desc = "Keymaps" })
map("n", "<leader>fb", "<cmd>Telescope buffers<CR>", { silent = true, desc = "Buffers" })

-------------------------------------------------
-- ToggleTerm
-------------------------------------------------
map("n", "<leader>tt", "<cmd>ToggleTerm direction=float<CR>", { silent = true, desc = "Toggle terminal (float)" })
map("t", "<leader>td", "<C-\\><C-n><cmd>ToggleTerm<CR>", { silent = true, desc = "Close terminal" })
map("n", "<leader>tg", "<cmd>lua _lazygit_toggle()<CR>", { silent = true, desc = "Toggle Lazygit" })

-------------------------------------------------
-- TreesJ
-------------------------------------------------
map("n", "<leader>tj", function()
	require("treesj").toggle()
end, { silent = true, desc = "Toggle split/join" })

-------------------------------------------------
-- Chowcho (window picker)
-------------------------------------------------
map("n", "<C-w><C-w>", "<cmd>Chowcho<CR>", { silent = true, desc = "Window picker" })

-------------------------------------------------
-- SSR (structural search replace)
-------------------------------------------------
map({ "n", "x" }, "<leader>sr", function()
	require("ssr").open()
end, { silent = true, desc = "Structural replace" })

-------------------------------------------------
-- Hop
-------------------------------------------------
map("n", "<leader>p", "<cmd>HopWord<CR>", { silent = true, desc = "Hop word" })

-------------------------------------------------
-- Smart Splits (resize)
-------------------------------------------------
map("n", "<leader>h", function()
	require("smart-splits").resize_left()
end, { desc = "Resize left" })

map("n", "<leader>j", function()
	require("smart-splits").resize_down()
end, { desc = "Resize down" })

map("n", "<leader>k", function()
	require("smart-splits").resize_up()
end, { desc = "Resize up" })

map("n", "<leader>l", function()
	require("smart-splits").resize_right()
end, { desc = "Resize right" })

-------------------------------------------------
-- Navbuddy
-------------------------------------------------
map("n", "<leader>nb", "<cmd>Navbuddy<CR>", { silent = true, desc = "Navbuddy" })

vim.keymap.set("n", "<leader>hb", function()
	require("gitsigns").toggle_current_line_blame()
end, { desc = "Toggle Git Blame" })

pcall(function()
	local wk = require("which-key")
	wk.register({
		g = { name = "Git" },
		a = { name = "AI" },
	}, { prefix = "<leader>" })
end)

-------------------------------------------------
-- Copilot Chat
-------------------------------------------------
map("n", "<leader>aa", "<cmd>CopilotChatToggle<CR>", { silent = true, desc = "AI Chat Toggle" })
map("n", "<leader>ae", "<cmd>CopilotChatExplain<CR>", { silent = true, desc = "AI Explain" })
map("n", "<leader>af", "<cmd>CopilotChatFix<CR>", { silent = true, desc = "AI Fix" })
map("n", "<leader>at", "<cmd>CopilotChatTests<CR>", { silent = true, desc = "AI Generate Tests" })
map("n", "<leader>ao", "<cmd>CopilotChatOptimize<CR>", { silent = true, desc = "AI Optimize" })
map("n", "<leader>ad", "<cmd>CopilotChatDocs<CR>", { silent = true, desc = "AI Generate Docs" })
map("n", "<leader>ac", "<cmd>CopilotChatCommit<CR>", { silent = true, desc = "AI Commit Message" })
map("v", "<leader>ae", "<cmd>CopilotChatExplain<CR>", { silent = true, desc = "AI Explain Selection" })
map("v", "<leader>af", "<cmd>CopilotChatFix<CR>", { silent = true, desc = "AI Fix Selection" })

map("n", "<leader>z", "<cmd>ZenMode<CR>", { desc = "Toggle Zen Mode" })
