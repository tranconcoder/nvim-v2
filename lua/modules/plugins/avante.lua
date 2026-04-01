return {
  {
    "yetone/avante.nvim",
    event = "VeryLazy",
    build = "make",
    dependencies = {
      "nvim-treesitter/nvim-treesitter",
      "stevearc/dressing.nvim",
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "nvim-tree/nvim-web-devicons",
      "github/copilot.vim",
      -- Markdown rendering in chat
      {
        "MeanderingProgrammer/render-markdown.nvim",
        opts = { file_types = { "markdown", "Avante" } },
        ft = { "markdown", "Avante" },
      },
    },
    opts = {
      provider = "copilot",
      providers = {
        copilot = {
          model = "claude-3.5-haiku",
        },
      },
      behaviour = {
        auto_suggestions = false,
        auto_set_highlight_group = true,
        auto_set_keymaps = true,
        auto_apply_diff_after_generation = false,
        support_paste_from_clipboard = false,
      },
      windows = {
        position = "right",
        wrap = true,
        width = 40,
        sidebar_header = {
          align = "center",
          rounded = true,
        },
      },
      hints = { enabled = true },
    },
    keys = {
      { "<leader>aa", "<cmd>AvanteAsk<CR>",      mode = { "n", "v" }, desc = "Avante Ask" },
      { "<leader>ae", "<cmd>AvanteEdit<CR>",     mode = { "v" },      desc = "Avante Edit selection" },
      { "<leader>ar", "<cmd>AvanteRefresh<CR>",  mode = "n",          desc = "Avante Refresh" },
      { "<leader>at", "<cmd>AvanteToggle<CR>",   mode = "n",          desc = "Avante Toggle" },
      { "<C-\\>",     "<cmd>AvanteToggle<CR>",   mode = "n",          desc = "Avante Toggle" },
    },
  },
}
