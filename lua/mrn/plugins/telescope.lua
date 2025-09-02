return {

	{
		"nvim-telescope/telescope.nvim",
		tag = "0.1.8",

		dependencies = {
			"nvim-lua/plenary.nvim",
			"nvim-telescope/telescope-ui-select.nvim",
		},

		config = function()
			require("telescope").setup({
				extensions = {
					["ui-select"] = {
						require("telescope.themes").get_dropdown(),
					},
				},
			})

			require("telescope").load_extension("ui-select")

			local builtin = require("telescope.builtin")
			vim.keymap.set("n", "<leader>ff", builtin.find_files, {})
			vim.keymap.set("n", "<C-f>", builtin.git_files, {})
			vim.keymap.set("n", "<leader>fs", function() builtin.grep_string({ search = vim.fn.input("Grep > ") }) end)
			vim.keymap.set("n", "<leader>fr", builtin.lsp_references, {})

			vim.keymap.set("n", "<leader>fw", function() builtin.grep_string({ search = vim.fn.expand("<cword>") }) end)

			vim.keymap.set("n", "<leader>fW", function() builtin.grep_string({ search = vim.fn.expand("<cWORD>") }) end)

			vim.keymap.set("n", "<leader>ht", builtin.help_tags, {})
		end,
	},
}
