vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

vim.keymap.set("n", "<S-Tab>", "<C-w><C-w>", { noremap = true, silent = true })
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader>=", ":vertical resize 25<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<leader><e>", ":edit ./", { noremap = true, silent = true })

