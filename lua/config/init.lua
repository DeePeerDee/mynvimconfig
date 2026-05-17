require "config.keymap"
require "config.options"
require "config.lazy"

-- Define your theme pairs here for easy editing
local themes = {
  day = {
    bg = "light",
    colorscheme = "dawnfox",
    lualine = "Tomorrow"
  },
  night = {
    bg = "dark",
    colorscheme = "vscode",
    lualine = "ayu_dark"
  }
}

-- Function Toggle
local function apply_theme()
  -- local config = themes[mode]

  -- vim.o.background = config.bg
  vim.o.background = "dark"
  -- vim.cmd.colorscheme(config.colorscheme)
  vim.cmd.colorscheme("edge")
  -- Sync Lualine
  local lualine = require("lualine")
  -- lualine.setup({ options = { theme = config.lualine } })
  lualine.setup({ options = { theme = "edge" } })
end

-- 2. Automatic Time Check
-- local function auto_theme_check()
--   local hour = tonumber(os.date("%H"))
--   -- Day is 8 AM to 4 PM (16:00)
--   if hour >= 8 and hour < 16 then
--     apply_theme("day")
--   else
--     apply_theme("night")
--   end
-- end

-- Initialize theme based on time
-- auto_theme_check()
apply_theme()

-- Theme Toggler
-- local function toggle_theme()
--   if vim.o.background == "light" then
--     apply_theme("night")
--   else
--     apply_theme("day")
--   end
-- end

-- local is_auto_toggle_enabled = true

-- local enable_disable_toggle = function()
--   is_auto_toggle_enabled = not is_auto_toggle_enabled
--   print("Auto toggle theme is now " .. (is_auto_toggle_enabled and "enabled" or "disabled"))
-- end

-- Live theme update on time change
-- local function update_theme_on_time_change()
--   local hour = tonumber(os.date("%H"))
--   local is_day = hour >= 8 and hour < 16
--
--   -- if is_auto_toggle_enabled and is_day and vim.o.background ~= "light" then
--     apply_theme("day")
--   -- elseif is_auto_toggle_enabled and not is_day and vim.o.background ~= "dark" then
--     -- apply_theme("night")
--   -- end
-- end

-- local timer = vim.loop.new_timer()
-- timer:start(0, 1 * 60 * 1000, vim.schedule_wrap(update_theme_on_time_change))
-- timer:start(0, 24 * 60 * 60 * 1000, vim.schedule_wrap(apply_theme("night")))

-- Keymap to toggle theme
-- vim.keymap.set("n", "<leader>tt", toggle_theme, { desc = "Toggle Theme" })
-- vim.keymap.set("n", "<leader>ta", enable_disable_toggle, { desc = "Enable/Disable Auto Theme" })

vim.filetype.add({
  extension = {
    razor = "razor",
    cshtml = "razor",
  },
})

local function get_lualine_themes()
  local themes = {}
  -- Scan all 'lua/lualine/themes/' directories in the runtime path
  local paths = vim.api.nvim_get_runtime_file("lua/lualine/themes/*.lua", true)

  for _, path in ipairs(paths) do
    -- 1. Verify the file actually exists and is readable on disk
    local stat = vim.uv.fs_stat(path)
    if stat and stat.type == "file" then
      -- 2. Extract the base name cleanly
      local theme = string.match(path, "([^/\\]+)%.lua$")
      -- 3. Filter out private/internal modules starting with an underscore
      if theme and not string.match(theme, "^_") then
        themes[theme] = true
      end
    end
  end

  -- Sort alphabetically for a clean menu
  local theme_list = vim.tbl_keys(themes)
  table.sort(theme_list)
  return theme_list
end

-- Create the user command with custom list completion
vim.api.nvim_create_user_command("LualineTheme", function(opts)
  local theme = opts.args
  if theme == "" then
    print("Current lualine theme: " .. (require("lualine").get_config().options.theme or "auto"))
    return
  end

  -- Safely protect against typos or invalid theme inputs
  local status, _ = pcall(require, "lualine.themes." .. theme)
  if not status then
    vim.notify("Lualine theme '" .. theme .. "' not found.", vim.log.levels.ERROR)
    return
  end

  -- Apply the theme dynamically
  require("lualine").setup({ options = { theme = theme } })
  print("Lualine theme changed to: " .. theme)
end, {
  nargs = "?", -- Accepts 0 or 1 argument (0 prints current theme)
  complete = function(ArgLead, CmdLine, CursorPos)
    -- Filter themes based on what the user has typed so far
    return vim.tbl_filter(function(theme)
      return string.match(theme, "^" .. vim.pesc(ArgLead))
    end, get_lualine_themes())
  end,
})
