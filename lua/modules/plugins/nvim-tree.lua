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
					width = {
						min = 30,
						max = -1,
						determinator = "window",
					},
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
					enable = true,
					update_cwd = false,
					ignore_list = {},
				},
				sync_root_with_cwd = false,
				respect_buf_cwd = false,
			})

			-- Keymaps
			vim.keymap.set("n", "<C-e>", function()
				local api = require("nvim-tree.api")
				if api.tree.is_visible() then
					api.tree.toggle()
				else
					api.tree.open()
					api.tree.find_file()
				end
			end, { desc = "Toggle nvim-tree" })
		end,
	},
}
