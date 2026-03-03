return {
  {
    "norcalli/nvim-colorizer.lua",
    config = function()
      require("colorizer").setup({
        "*",
        html = { mode = "foreground" },
        css = { rgb_fn = true, hsl_fn = true, names = false },
      })
    end,
  }
}
