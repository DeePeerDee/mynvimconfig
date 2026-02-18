vim.api.nvim_create_user_command("UseProjectVenv", function()
  vim.g.python3_host_prog = vim.fn.getcwd() .. "/venv/bin/python"
  print("Using project venv: " .. vim.fn.getcwd() .. "/venv")
end, {})

vim.filetype.add({
  extension = {
    ipynb = "markdown",
  },
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "*.ipynb",
  callback = function()
    vim.bo.filetype = "markdown"
  end,
})

require "config.keymap"
require "config.options"
require "config.lazy"
