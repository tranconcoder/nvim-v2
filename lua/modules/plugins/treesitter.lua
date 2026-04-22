return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    require("nvim-treesitter.config").setup({
      ensure_installed = { "lua", "vim", "vimdoc", "bash", "json", "yaml", "markdown", "markdown_inline" },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
    })

    -- Fixed width configuration for focus/normal states
    local NORMAL_WIDTH = 50   -- Width when not focused (smaller preview)
    local FOCUS_WIDTH = 200   -- Width when focused on treesitter buffer
    local ANIMATION_STEPS = 5  -- Number of animation frames (faster)
    local ANIMATION_DELAY = 15  -- Delay in ms between steps (faster)
    local group = vim.api.nvim_create_augroup("treesitter-focus", { clear = true })
    
    local current_animation_timer = nil
    
    local function animate_width(target_width)
      -- Cancel any existing animation safely
      if current_animation_timer then
        pcall(function()
          current_animation_timer:stop()
          current_animation_timer:close()
        end)
        current_animation_timer = nil
      end

      pcall(function()
        local current_win = vim.api.nvim_get_current_win()
        if not vim.api.nvim_win_is_valid(current_win) then
          return
        end

        local current_width = vim.api.nvim_win_get_width(current_win)
        local width_diff = target_width - current_width
        local step_size = width_diff / ANIMATION_STEPS
        local step = 0

        -- Capture the timer in a local variable so the callback always
        -- refers to the correct timer instance even if current_animation_timer
        -- is replaced or cleared elsewhere.
        local timer = vim.loop.new_timer()
        current_animation_timer = timer
        timer:start(0, ANIMATION_DELAY, vim.schedule_wrap(function()
          step = step + 1

          if step >= ANIMATION_STEPS then
            -- Final step - set exact target width
            if vim.api.nvim_win_is_valid(current_win) then
              vim.api.nvim_win_set_width(current_win, target_width)
            end
            -- Stop only this timer instance safely
            pcall(function()
              timer:stop()
              timer:close()
            end)
            if current_animation_timer == timer then
              current_animation_timer = nil
            end
            return
          end

          if vim.api.nvim_win_is_valid(current_win) then
            local new_width = math.floor(current_width + (step_size * step))
            vim.api.nvim_win_set_width(current_win, new_width)
          end
        end))
      end)
    end
    
    local function is_treesitter_buffer()
      local buftype = vim.bo.buftype
      -- Exclude terminal and special buffers
      if buftype == "terminal" or buftype == "nofile" or buftype == "prompt" then
        return false
      end
      
      local filename = vim.api.nvim_buf_get_name(0)
      -- Exclude empty buffers and special buffers
      if filename == "" or filename:match("NvimTree") or filename:match("Telescope") then
        return false
      end
      
      return true
    end
    
    vim.api.nvim_create_autocmd("VimLeavePre", {
      group = group,
      callback = function()
        if current_animation_timer then
          pcall(function()
            current_animation_timer:stop()
            current_animation_timer:close()
          end)
          current_animation_timer = nil
        end
      end,
    })

    -- On entering a buffer
    vim.api.nvim_create_autocmd("BufEnter", {
      group = group,
      callback = function()
        if is_treesitter_buffer() then
          -- Animate expand for treesitter buffers
          animate_width(FOCUS_WIDTH)
        else
          -- Animate shrink for terminal and special buffers (keep visible at 50px)
          animate_width(NORMAL_WIDTH)
        end
      end,
    })
  end,
}
