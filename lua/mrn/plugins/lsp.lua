return {
	{
		"neovim/nvim-lspconfig",

		dependencies = {
			{ "mason-org/mason.nvim", opts = {} },

			"mason-org/mason-lspconfig.nvim",
			"WhoIsSethDaniel/mason-tool-installer.nvim",

			{
				-- configures lua_ls for editing nvim cfg
				"folke/lazydev.nvim",
				ft = "lua", -- only load on lua files
				opts = {
					library = {
						-- Load luvit types when the `vim.uv` word is found
						{ path = "${3rd}/luv/library", words = { "vim%.uv" } },
					},
				},
			},

			{ "j-hui/fidget.nvim", opts = {} },

			"saghen/blink.cmp",
		},

		config = function()
			require("mason-lspconfig").setup({
				ensure_installed = {},
				automatic_enable = true,
			})

			if vim.fn.has("win32") == 1 then
				vim.lsp.config("arduino_language_server", {
					cmd = {
						"arduino-language-server",
						"-cli-config",
						"%localappdata%\\Arduino15\\arduino-cli.yaml",
					},
				})
			end
		end,
	},
	{

		"saghen/blink.cmp",
		version = "1.*",
		event = "VimEnter",

		dependencies = {
			{
				"L3MON4D3/LuaSnip",
				version = "v2.*",
				build = "make install_jsregexp",

				dependencies = {
					{
						"rafamadriz/friendly-snippets",

						config = function() require("luasnip.loaders.from_vscode").lazy_load() end,
					},
				},
			},
		},

		opts = {
			keymap = { preset = "default" },

			appearance = {
				nerd_font_variant = "normal",
			},

			completion = {
				list = {
					selection = { preselect = true, auto_insert = false },
				},

				menu = {
					draw = {
						gap = 2,
						components = {
							-- customize the drawing of kind icons
							kind_icon = {
								text = function(ctx)
									-- default kind icon
									local icon = ctx.kind_icon
									-- if LSP source, check for color derived from documentation
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr ~= "" then icon = color_item.abbr end
									end
									return icon .. ctx.icon_gap
								end,
								highlight = function(ctx)
									-- default highlight group
									local highlight = "BlinkCmpKind" .. ctx.kind
									-- if LSP source, check for color derived from documentation
									if ctx.item.source_name == "LSP" then
										local color_item = require("nvim-highlight-colors").format(
											ctx.item.documentation,
											{ kind = ctx.kind }
										)
										if color_item and color_item.abbr_hl_group then
											highlight = color_item.abbr_hl_group
										end
									end
									return highlight
								end,
							},
						},
					},
				},

				documentation = {
					auto_show = true,
				},
			},

			sources = {
				--lazydev
				default = { "lazydev", "lsp", "path", "snippets", "buffer" },
				providers = {
					lazydev = {
						name = "LazyDev",
						module = "lazydev.integrations.blink",
						-- make lazydev completions top priority (see `:h blink.cmp`)
						score_offset = 100,
					},
				},
			},

			snippets = { preset = "luasnip" },

			fuzzy = { implementation = "prefer_rust_with_warning" },

			signature = {
				enabled = true,
			},
		},
	},
	{
		"stevearc/conform.nvim",
		event = "BufWritePre",
		cmd = "ConformInfo",

		opts = {
			notify_on_error = false,

			format_on_save = function(bufnr)
				local disable_filetypes = {}
				if disable_filetypes[vim.bo[bufnr].filetype] then
					return nil
				else
					return {
						timeout_ms = 500,
						lsp_format = "fallback",
					}
				end
			end,

			formatters_by_ft = {
				lua = { "stylua" },
				java = { "google-java-format" },
				cs = { "csharpier" },
				json = { "jq" },
				html = { "prettierd" },
				css = { "prettierd" },
				javascript = { "prettierd" },
			},

			formatters = {
				stylua = {
					append_args = { "--collapse-simple-statement", "Always" },
				},
				prettierd = {
					append_args = { "--tabWidth=4" },
				},
			},
		},
	},
}
