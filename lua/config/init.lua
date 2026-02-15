vim.api.nvim_create_user_command("UseProjectVenv", function()
  vim.g.python3_host_prog = vim.fn.getcwd() .. "/venv/bin/python"
  print("Using project venv: " .. vim.fn.getcwd() .. "/venv")
end, {})

require "config.keymap"
require "config.options"
require "config.lazy"
