vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })
vim.keymap.set("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostic quickfix list" })
vim.keymap.set("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Window navigation
vim.keymap.set("n", "<C-h>", "<C-w><C-h>", { desc = "Move to left window" })
vim.keymap.set("n", "<C-l>", "<C-w><C-l>", { desc = "Move to right window" })
vim.keymap.set("n", "<C-j>", "<C-w><C-j>", { desc = "Move to lower window" })
vim.keymap.set("n", "<C-k>", "<C-w><C-k>", { desc = "Move to upper window" })
