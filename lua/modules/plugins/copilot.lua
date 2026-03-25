return {
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      -- Bypass self-signed certificate errors (corporate proxy / VPN)
      vim.g.copilot_proxy_strict_ssl = false

      -- Disable default Tab mapping (conflicts with nvim-cmp)
      vim.g.copilot_no_tab_map = true

      -- Accept suggestion with Ctrl+J
      vim.keymap.set("i", "<C-j>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
        desc = "Copilot: Accept suggestion",
      })

      -- Next / previous suggestion
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)", { desc = "Copilot: Next suggestion" })
      vim.keymap.set("i", "<M-[>", "<Plug>(copilot-previous)", { desc = "Copilot: Previous suggestion" })

      -- Dismiss suggestion
      vim.keymap.set("i", "<C-e>", "<Plug>(copilot-dismiss)", { desc = "Copilot: Dismiss suggestion" })

      -- Suggest explicitly
      vim.keymap.set("i", "<C-/>", "<Plug>(copilot-suggest)", { desc = "Copilot: Trigger suggestion" })
    end,
  },
}
