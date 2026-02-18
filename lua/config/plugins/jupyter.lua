return {
  {
    "benlubas/molten-nvim",
--    version = "^1.0.0",  -- Uncomment if you want to pin a version
    build = ":UpdateRemotePlugins",
    dependencies = { "3rd/image.nvim" },
    init = function()
      -- These are examples, not defaults. See the README for more options.
      vim.g.molten_image_provider = "image.nvim"
      vim.g.molten_output_win_max_height = 20
      vim.keymap.set("n", "<localleader>mi", ":MoltenInit<CR>", { desc = "Initialize Molten (start kernel)" })
      vim.keymap.set("n", "<localleader>me", ":MoltenEvaluationOperator<CR>", { desc = "Evaluate operator" })
      vim.keymap.set("n", "<localleader>ml", ":MoltenEvaluateLine<CR>", { desc = "Evaluate line" })
      vim.keymap.set("n", "<localleader>mv", ":<C-u>MoltenEvaluateVisual<CR>gv", { desc = "Evaluate visual selection" })
      vim.keymap.set("n", "<localleader>mc", ":MoltenEvaluateCell<CR>", { desc = "Evaluate cell (block between # %% markers)" })
      vim.keymap.set("n", "<localleader>ma", ":MoltenEvaluateCellAbove<CR>", { desc = "Evaluate cell above" })
      vim.keymap.set("n", "<localleader>mb", ":MoltenEvaluateCellBelow<CR>", { desc = "Evaluate cell below" })
      vim.keymap.set("n", "<localleader>mr", ":MoltenRestart<CR>", { desc = "Restart Kernel" })
      vim.keymap.set("n", "<localleader>mh", ":MoltenHideOutput<CR>", { desc = "Hide output" })
      vim.keymap.set("n", "<localleader>ms", ":MoltenShowOutput<CR>", { desc = "Show output" })
      vim.keymap.set("n", "<localleader>md", ":MoltenDelete<CR>", { desc = "Delete current cell output" })
      vim.keymap.set("n", "<localleader>mo", ":MoltenEnterOutput<CR>", { desc = "Enter output window" })
      vim.keymap.set("n", "<localleader>ic", "o# %%<CR><CR>", { desc = "Insert new cell below (with # %% marker)" })
      vim.keymap.set("n", "<localleader>ia", "O# %%<CR><CR>", { desc = "Insert new cell above" })
    end,
  },
  {
    -- See the image.nvim README for more configuration options
    "3rd/image.nvim",
    opts = {
      backend = "kitty",  -- Use "kitty" if you're using Kitty terminal; change to "wezterm" or "ueberzug" if using others
      max_width = 100,
      max_height = 12,
      max_height_window_percentage = math.huge,
      max_width_window_percentage = math.huge,
      window_overlap_clear_enabled = true,  -- Toggles images when windows overlap
      window_overlap_clear_ft_ignore = { "cmp_menu", "cmp_docs", "" },
      lua_version = "5.1",
    },
  },
  {
    "jmbuhr/otter.nvim",
    dependencies = {
      "neovim/nvim-lspconfig",
      "nvim-treesitter/nvim-treesitter",
    },
    opts = {
      lsp = {
        python = {
          diagnostics = { enabled = true },
          completion = { enabled = true },
          hover = { enabled = true },
        },
      },
    },
    config = function()
      local otter = require("otter")
      vim.api.nvim_create_autocmd("FileType", {
        pattern = { "markdown" },
        callback = function()
          otter.activate({ "python" }, true, true, nil)
        end,
      })
    end,
  },
  {
    "GCBallesteros/jupytext.nvim",
    opts = {
      custom_language_formatting = {
        python = {
          extension = "ipynb",
          style = "py:percent",
          force_ft = "python",
        },
      },
    },
  }
}
