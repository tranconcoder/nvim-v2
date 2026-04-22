return {
	{
		"nvim-tree/nvim-tree.lua",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		lazy = false,
		priority = 100,
		config = function()
			-- Disable netrw (must be before setup)
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			require("nvim-tree").setup({
				-- Show hidden files (.env, .gitignore, etc.)
				filters = {
					dotfiles = false,
					custom = {}, -- Add patterns to exclude: { "^.git$" }
				},

				view = {
					width = 30,
					side = "left",
					number = false,
					relativenumber = false,
					float = {
						enable = false,
					},
					autofocus = false,
				},

				renderer = {
					highlight_opened_files = "all",
					indent_markers = {
						enable = true,
					},
					icons = {
						show = {
							file = true,
							folder = true,
							folder_arrow = true,
							git = true,
							modified = true,
						},
					},
				},

				git = {
					enable = true,
					ignore = false, -- Show ignored files
				},

				actions = {
					open_file = {
						resize_window = false,
						quit_on_open = true,
						window_picker = {
							enable = false,
						},
					},
				},

				update_focused_file = {
					enable = false,
					update_cwd = false,
					ignore_list = {},
				},
				sync_root_with_cwd = false,
				respect_buf_cwd = false,
				hijack_cursor = false,
				auto_close = false,
		})

		-- Auto-find current file in nvim-tree when buffer changes (only if tree is visible)
		vim.api.nvim_create_autocmd("BufEnter", {
			group = vim.api.nvim_create_augroup("nvim-tree-find-file", { clear = true }),
			callback = function()
				local ok, api = pcall(require, "nvim-tree.api")
				if ok and api.tree.is_visible() then
					local bufname = vim.api.nvim_buf_get_name(0)
					if bufname ~= "" and vim.bo.buftype == "" then
						vim.defer_fn(function()
							pcall(api.tree.find_file, { open = false, focus = false })
						end, 10)
					end
				end
			end,
		})

		-- Keymaps
		vim.keymap.set("n", "<A-e>", function()
				local api = require("nvim-tree.api")
				if api.tree.is_visible() then
					api.tree.close()
				else
					api.tree.open()
					api.tree.find_file()
				end
			end, { desc = "Toggle nvim-tree" })
		end,
	},
}
