return {
	"nvim-lualine/lualine.nvim",

	config = function()
		local function branch()
			local branch = vim.fn.FugitiveHead()
			return branch ~= "" and " " .. branch or ""
		end

		local function diff_source()
			local gitsigns = vim.b.gitsigns_status_dict
			if gitsigns then
				return {
					added = gitsigns.added,
					modified = gitsigns.changed,
					removed = gitsigns.removed,
				}
			end
		end

		require("lualine").setup({
			options = {
				theme = "rose-pine",
			},
			sections = {
				lualine_b = { branch, { "diff", source = diff_source } },
				lualine_c = { { "filename", newfile_status = true, path = 1 } },

				lualine_x = { "encoding", "filetype" },
				lualine_y = { "lsp_status" },
			},
			inactive_sections = {
				lualine_b = { branch, { "diff", source = diff_source } },
				lualine_c = { { "filename", newfile_status = true, path = 1 } },

				lualine_x = { "encoding", "filetype" },
				lualine_z = { "location" },
			},
		})
	end,
}
