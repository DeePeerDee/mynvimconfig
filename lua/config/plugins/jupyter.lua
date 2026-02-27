return {
  -- 1. Molten: The Jupyter Kernel Client
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version 1 for stability
    build = ":UpdateRemotePlugins",
    init = function()
      -- These are required for image.nvim integration
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
    end,
  },

  -- 2. Quarto or Iron.nvim (Optional, but Quarto is great for "Cells")
  {
    "quarto-dev/quarto-nvim",
    dependencies = { "jmbuhr/otter.nvim" },
    opts = {
      codeRunner = {
        enabled = true,
        default_method = "molten",
      },
    },
  },
}
