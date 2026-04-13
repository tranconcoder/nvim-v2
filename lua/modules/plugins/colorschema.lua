return {
	{
		"uloco/bluloco.nvim",
		lazy = false,
		priority = 1000,
		dependencies = { "rktjmp/lush.nvim" },
		config = function()
			require("bluloco").setup({
				style = "auto", -- Tự động theo vim.o.background
				transparent = false, -- Đổi thành true nếu bạn muốn dùng nền của Hyprland/Kitty
				italics = true, -- Bật chữ nghiêng cho đẹp (nếu font hỗ trợ)
				terminal = true,
			})

			-- Kích hoạt theme
			vim.opt.termguicolors = true
			vim.cmd("colorscheme bluloco")
		end,
	},
}
