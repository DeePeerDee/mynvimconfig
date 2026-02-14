vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.keymap.set("n", "<S-Tab>", "<C-w><C-w>", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>=", ":vertical resize 25<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><e>", ":edit ./", { noremap = true, silent = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(ev)
    local opts = { buffer = ev.buf, silent = true }
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("n", "<C-k>", vim.lsp.buf.signature_help, opts)
    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, opts)
    vim.keymap.set({"n", "v"}, "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, opts)
  end,
})
