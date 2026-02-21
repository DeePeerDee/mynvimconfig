return {
  {
    "nvim-tree/nvim-tree.lua",
    opts = {
      view = { width = 35, side = "left" },
      update_focused_file = { enable = true },
      renderer = { indent_markers = { enable = true } },
    },
    config = function(_, opts)
      require("nvim-tree").setup(opts)
      vim.keymap.set("n", "<leader>e", ":NvimTreeToggle<CR>", { desc = "Explorer" })
    end,
  },
}
