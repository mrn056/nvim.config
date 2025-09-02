require("mrn.remaps")
require("mrn.set")

require("mrn.lazy")

local autocmd = vim.api.nvim_create_autocmd
local augroup = vim.api.nvim_create_augroup
local mrnGroup = augroup("mrn", { clear = true })

autocmd("TextYankPost", {
	group = augroup("highlight_yank", { clear = true }),
	pattern = "*",
	callback = function() vim.highlight.on_yank({ higroup = "IncSearch", timeout = 150 }) end,
})

autocmd("BufWritePre", {
	group = mrnGroup,
	pattern = "*",
	command = [[%s/\s\+$//e]],
})

autocmd("LspAttach", {
	group = mrnGroup,
	callback = function(e)
		local opts = { buffer = e.buf }
		vim.keymap.set("n", "gd", function() vim.lsp.buf.definition() end, opts)
		vim.keymap.set("n", "K", function() vim.lsp.buf.hover() end, opts)
		vim.keymap.set("n", "<leader>vws", function() vim.lsp.buf.workspace_symbol() end, opts)
		vim.keymap.set("n", "<leader>vd", function() vim.diagnostic.open_float() end, opts)
		vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, opts)
		vim.keymap.set("n", "<leader>vrr", function() vim.lsp.buf.references() end, opts)
		vim.keymap.set("n", "<leader>vrn", function() vim.lsp.buf.rename() end, opts)
		vim.keymap.set("i", "<C-h>", function() vim.lsp.buf.signature_help() end, opts)
	end,
})

autocmd("LspAttach", {
	group = mrnGroup,
	callback = function(e)
		local client = vim.lsp.get_client_by_id(e.data.client_id)
		client.server_capabilities.semanticTokensProvider = nil
	end,
})

vim.diagnostic.config({
	update_in_insert = true,
	underline = { severity = vim.diagnostic.severity.ERROR },
	signs = {
		text = {
			[vim.diagnostic.severity.ERROR] = "󰅚 ",
			[vim.diagnostic.severity.WARN] = "󰀪 ",
			[vim.diagnostic.severity.INFO] = "󰋽 ",
			[vim.diagnostic.severity.HINT] = "󰌶 ",
		},
	},

	float = {
		border = "rounded",
		source = true,
		header = "",
		prefix = "",
	},

	virtual_text = {
		source = "if_many",
		spacing = 2,
	},
})
