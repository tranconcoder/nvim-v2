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
						max = -1, -- 45% of window
						determinator = "window",
					},
					side = "left",
					number = false,
					relativenumber = false,
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
						resize_window = true,
						quit_on_open = false,
					},
				},

				update_focused_file = {
					enable = true,
				},
			})

			-- Keymaps
			vim.keymap.set("n", "<leader>e", "<cmd>NvimTreeToggle<CR>", { desc = "Toggle file explorer" })
			vim.keymap.set("n", "<leader>E", "<cmd>NvimTreeFindFile<CR>", { desc = "Find file in explorer" })
		end,
	},
}
