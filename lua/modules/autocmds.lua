vim.api.nvim_create_autocmd({ "FocusLost", "BufLeave" }, {
  group = vim.api.nvim_create_augroup("auto-save", { clear = true }),
  callback = function(args)
    local buf = args.buf
    if
      vim.api.nvim_buf_is_valid(buf)
      and vim.bo[buf].modified
      and not vim.bo[buf].readonly
      and vim.api.nvim_buf_get_name(buf) ~= ""
      and vim.bo[buf].buftype == ""
    then
      vim.api.nvim_buf_call(buf, function()
        -- Save without triggering swap file updates
        vim.cmd("silent! noautocmd write")
      end)
    end
  end,
})

vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

-- Handle swap file conflicts - auto-choose 'read from disk' when file hasn't been modified
vim.api.nvim_create_autocmd("SwapExists", {
  group = vim.api.nvim_create_augroup("swap-exists", { clear = true }),
  callback = function()
    vim.v.swapchoice = "e"  -- 'e' = edit anyway, 'r' = read from swap, 'd' = delete swap
  end,
})
