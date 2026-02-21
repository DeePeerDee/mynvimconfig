return {
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode = "buffers",
        separator_style = "thin",
        -- THIS IS THE MAGIC FOR THE IDE LOOK:
        offsets = {
          {
            filetype = "NvimTree",
            text = "EXPLORER",
            text_align = "center",
            separator = true,
          },
          {
            filetype = "dbui",
            text = "DATABASE",
            text_align = "center",
            separator = true,
          },
        },
      },
    },
  },
}
