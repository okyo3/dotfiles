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
			local enabled_servers = {}
			local capabilities = vim.lsp.protocol.make_client_capabilities()
			capabilities = require("blink.cmp").get_lsp_capabilities(capabilities)

			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = { "gopls" },
				automatic_installation = true,
			})

			vim.lsp.config("*", {
				capabilities = capabilities,
			})

			vim.lsp.config("gopls", {
				settings = {
					gopls = {
						gofumpt = true,
						staticcheck = true,
						analyses = {
							unusedparams = true,
							shadow = true,
						},
					},
				},
			})

			for _, server in ipairs(require("mason-lspconfig").get_installed_servers()) do
				enabled_servers[server] = true
				vim.lsp.enable(server)
			end

			if not enabled_servers.gopls then
				vim.lsp.enable("gopls")
			end

			vim.diagnostic.config({
				virtual_text = false,
				severity_sort = true,
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
		},
		opts = {
			keymap = {
				["<CR>"] = { "accept", "fallback" },
			},

			snippets = {
				expand = function(snippet)
					require("luasnip").lsp_expand(snippet)
				end,
			},

			completion = {
				ghost_text = {
					enabled = true,
				},
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
					"omni",
				},
				providers = {
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
