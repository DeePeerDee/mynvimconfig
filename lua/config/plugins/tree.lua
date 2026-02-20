return {
  {
    "nvim-tree/nvim-tree.lua",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
    },
    config = function()
      vim.opt.title = true
      vim.opt.titlestring = "%f"
      
      local function my_on_attach(bufnr)
        local api = require("nvim-tree.api")
        local function opts(desc)
          return { desc = "nvim-tree: " .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
        end
        api.config.mappings.default_on_attach(bufnr)
        vim.keymap.set("n", "o", api.node.open.vertical, opts("Open: vertical split"))
      end

      require("nvim-tree").setup({
        on_attach = my_on_attach,
        actions = {
          open_file = {
            quit_on_open = false,
          },
        },
        view = {
          side = "left",
          width = 30,
        },
      })
    end
  }
}
