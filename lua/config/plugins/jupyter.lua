return {
  {
    "benlubas/molten-nvim",
    build = ":UpdateRemotePlugins",
    init = function()
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
  },
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
    },
    opts = {},
  },
  {
    "quarto-dev/quarto-nvim",
    dependencies = {
      "jmbuhr/otter.nvim",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lsp_features = {
        languages = { "python" },
        chunks = "all",
        diagnostics = { enabled = true },
        completion = { enabled = true },
      },
    },
  },
}
