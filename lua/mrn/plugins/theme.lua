return {
	{
		"rose-pine/neovim",
		name = "rose-pine",
		priority = 1000,

		config = function()
			require("rose-pine").setup({
				styles = {
					italic = false,
				},
				highlight_groups = {
					CurSearch = { fg = "base", bg = "leaf", inherit = false },
					Search = { fg = "text", bg = "leaf", blend = 20, inherit = false },

					NormalFloat = { bg = "base" },
					FloatBorder = { bg = "none", fg = "muted" },
					TelescopeBorder = { bg = "none", fg = "muted" },

					BlinkCmpMenu = { bg = "base" },
					BlinkCmpDoc = { bg = "base" },
					BlinkCmpMenuBorder = { fg = "muted" },
					BlinkCmpDocBorder = { fg = "muted" },

					["@type.builtin"] = { fg = "love" },
				},
			})

			vim.cmd("colorscheme rose-pine")
		end,
	},
	{
		"echasnovski/mini.icons",

		config = function()
			require("mini.icons").setup({})
			MiniIcons.mock_nvim_web_devicons()
		end,
	},
	{
		"prichrd/netrw.nvim",

		opts = {
			icons = {
				directory = "",
			},
		},
	},
}
