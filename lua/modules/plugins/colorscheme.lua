return {
  "navarasu/onedark.nvim",
  priority = 1000,
  config = function()
    require("onedark").setup({
      style = "dark",
      transparent = false,
      lualine = true,
      telescope = true,
    })
    vim.cmd.colorscheme("onedark")
  end,
}
