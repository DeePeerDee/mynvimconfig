return {
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    opts = {
      options = {
        mode = "buffers",
        numbers = "ordinal",
        always_show_bufferline = false,
        custom_filter = function(buf_number)
          -- Filter out filetypes you don't want to see
          local exclude_ft = { "NvimTree", "qf", "help", "dbui" }
          local ft = vim.bo[buf_number].filetype
          for _, e in ipairs(exclude_ft) do
            if ft == e then
              return false
            end
          end
          return true
        end,
        separator_style = "thin",
        manage_groups = true,
        offsets = {
          {
            filetype = "NvimTree",
            text = "EXPLORER",
            text_align = "left",
            separator = true,
          },
          {
            filetype = "dbui",
            text = "DATABASE",
            text_align = "left",
            separator = true,
          },
        },
      },
    },
  },
}
