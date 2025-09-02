return {
	"folke/trouble.nvim",

	config = function()
		local trouble = require("trouble")
		trouble.setup({})

		vim.keymap.set("n", "<leader>tt", function() trouble.toggle("diagnostics") end)

		vim.keymap.set("n", "[t", function() trouble.next({ jump = true }) end)
		vim.keymap.set("n", "]t", function() trouble.prev({ jump = true }) end)
	end,
}
