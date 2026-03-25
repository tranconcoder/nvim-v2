return {
  "nvim-telescope/telescope.nvim",
  event = "VimEnter",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    "nvim-telescope/telescope-ui-select.nvim",
  },
  config = function()
    local telescope = require("telescope")
    telescope.setup({
      extensions = {
        ["ui-select"] = { require("telescope.themes").get_dropdown() },
      },
    })
    pcall(telescope.load_extension, "fzf")
    pcall(telescope.load_extension, "ui-select")

    local builtin = require("telescope.builtin")
    vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
    vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
    vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Find buffers" })
    vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
    vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
    vim.keymap.set("n", "<leader>fr", builtin.resume, { desc = "Resume last search" })
    vim.keymap.set("n", "<leader>f.", builtin.oldfiles, { desc = "Recent files" })
  end,
}
