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
        vim.cmd("silent! write")
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
