return {
	"mbbill/undotree",

	config = function()
		if vim.fn.has("win32") == 1 then vim.g.undotree_DiffCommand = "fc" end

		vim.keymap.set("n", "<leader>u", vim.cmd.UndotreeToggle)
	end,
}
