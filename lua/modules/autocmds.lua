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

-- Auto-reveal current file in nvim-tree on focus
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("nvim-tree-reveal", { clear = true }),
  callback = function()
    local bufname = vim.api.nvim_buf_get_name(0)
    local buftype = vim.bo.buftype
    
    -- Skip special buffers and nvim-tree itself
    if bufname == "" or buftype ~= "" or bufname:match("NvimTree") then
      return
    end
    
    -- Only reveal if it's a readable file
    if vim.fn.filereadable(bufname) == 1 then
      local ok, api = pcall(require, "nvim-tree.api")
      if ok then
        -- Use a deferred call to avoid conflicts with other autocommands
        vim.defer_fn(function()
          pcall(api.tree.find_file, { open = true, focus = false })
        end, 10)
      end
    end
  end,
})
