return {
  {
    "nvim-telescope/telescope.nvim",
    cmd = "Telescope",
    config = function()
      require("telescope").setup()
    end,
  }
}
