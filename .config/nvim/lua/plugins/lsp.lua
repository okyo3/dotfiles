return {
	-------------------------------------------------
	-- Mason
	-------------------------------------------------
	{
		"williamboman/mason.nvim",
		build = ":MasonUpdate",
		config = true,
	},

	-------------------------------------------------
	-- LSP
	-------------------------------------------------
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			"williamboman/mason.nvim",
			"williamboman/mason-lspconfig.nvim",
		},
		config = function()
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

			require("mason").setup()
			require("mason-lspconfig").setup({
				automatic_installation = true,
			})

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
				vim.lsp.enable(server)
			end

			vim.diagnostic.config({
				virtual_text = false,
				severity_sort = true,
			})
		end,
	},

	-------------------------------------------------
	-- none-ls
	-------------------------------------------------
	{
		"nvimtools/none-ls.nvim",
		dependencies = {
			"williamboman/mason.nvim",
			"jay-babu/mason-null-ls.nvim",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			local null_ls = require("null-ls")

			require("mason-null-ls").setup({
				automatic_installation = true,
			})

			null_ls.setup({
				sources = {
					-- null_ls.builtins.formatting.prettier,
					-- null_ls.builtins.formatting.stylua,
					-- null_ls.builtins.diagnostics.eslint,
				},
			})
		end,
	},

	-------------------------------------------------
	-- blink-cmp
	-------------------------------------------------
	{
		"Saghen/blink.cmp",
		version = "1.*",
		event = "InsertEnter",
		dependencies = {
			"L3MON4D3/LuaSnip",
			"zbirenbaum/copilot.lua",
			"fang2hou/blink-copilot",
		},
		opts = {
			snippets = {
				expand = function(snippet)
					require("luasnip").lsp_expand(snippet)
				end,
			},

			completion = {
				menu = {
					border = "rounded",
					draw = {
						columns = {
							{ "label", "label_description", gap = 1 },
							{ "kind_icon", "kind" },
						},
					},
				},
				list = {
					max_items = 20,
				},
			},

			sources = {
				default = {
					"lsp",
					"snippets",
					"buffer",
					"path",
					"copilot",
					"omni",
				},
				providers = {
					copilot = {
						module = "blink-copilot",
						name = "copilot",
						score_offset = 100,
					},
					buffer = {
						opts = {
							get_bufnrs = vim.api.nvim_list_bufs,
						},
					},
				},
			},

			cmdline = {
				enabled = true,
				sources = function()
					local type = vim.fn.getcmdtype()
					if type == ":" then
						return { "path", "cmdline" }
					end
					return {}
				end,
			},
		},
	},
	{
		"nvimdev/lspsaga.nvim",
		event = "LspAttach",
		dependencies = {
			"nvim-tree/nvim-web-devicons",
		},
		opts = {
			lightbulb = { enable = false },
		},
	},
}
