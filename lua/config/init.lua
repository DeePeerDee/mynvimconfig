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
local function apply_theme(mode)
  local config = themes[mode]

  vim.o.background = config.bg
  vim.cmd.colorscheme(config.colorscheme)
  -- Sync Lualine
  local lualine = require("lualine")
  lualine.setup({ options = { theme = config.lualine } })
end

-- 2. Automatic Time Check
local function auto_theme_check()
  local hour = tonumber(os.date("%H"))
  -- Day is 8 AM to 4 PM (16:00)
  if hour >= 8 and hour < 16 then
    apply_theme("day")
  else
    apply_theme("night")
  end
end

-- Initialize theme based on time
auto_theme_check()

-- Theme Toggler
local function toggle_theme()
  if vim.o.background == "light" then
    apply_theme("night")
  else
    apply_theme("day")
  end
end

local is_auto_toggle_enabled = true

local enable_disable_toggle = function()
  is_auto_toggle_enabled = not is_auto_toggle_enabled
  print("Auto toggle theme is now " .. (is_auto_toggle_enabled and "enabled" or "disabled"))
end

-- Live theme update on time change
local function update_theme_on_time_change()
  local hour = tonumber(os.date("%H"))
  local is_day = hour >= 8 and hour < 16

  if is_auto_toggle_enabled and is_day and vim.o.background ~= "light" then
    apply_theme("day")
  elseif is_auto_toggle_enabled and not is_day and vim.o.background ~= "dark" then
    apply_theme("night")
  end
end

local timer = vim.loop.new_timer()
timer:start(0, 1 * 60 * 1000, vim.schedule_wrap(update_theme_on_time_change))

-- Keymap to toggle theme
vim.keymap.set("n", "<leader>tt", toggle_theme, { desc = "Toggle Theme" })
vim.keymap.set("n", "<leader>ta", enable_disable_toggle, { desc = "Enable/Disable Auto Theme" })
