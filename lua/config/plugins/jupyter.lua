return {
  -- 1. Molten: The Jupyter Kernel Client
  {
    "benlubas/molten-nvim",
    version = "^1.0.0", -- use version 1 for stability
    dependencies = { "3rd/image.nvim" },
    build = ":UpdateRemotePlugins",
    init = function()
      -- These are required for image.nvim integration
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20

      vim.api.nvim_set_keymap(
        "n",
        "<leader>mi",
        "<cmd>MoltenInit<CR>",
        { noremap = true, silent = true }
      )
      vim.api.nvim_set_keymap(
        "n",
        "<leader>ml",
        "<cmd>MoltenEvaluateLine<CR>",
        { noremap = true, silent = true }
      )
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
  {
    "3rd/image.nvim",
    opts = {
      backend = "kitty",
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
    },
  },
}
