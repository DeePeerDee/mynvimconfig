return {
  {
    "3rd/image.nvim",
    dependencies = { "vhyrro/luarocks.nvim" }, -- Optional: helps manage the rock
    opts = {
      backend = "kitty",
      processor = "magick_rock", -- Use the library we installed in Step 2
      integrations = {
        markdown = {
          enabled = true,
          clear_in_insert_mode = false,
          download_remote_images = true,
          only_render_image_at_cursor = false,
          filetypes = { "markdown", "vimwiki" },
        },
      },
      max_height_window_percentage = 50,
      hijack_file_patterns = { "*.png", "*.jpg", "*.jpeg", "*.gif", "*.webp" },
    },
  },
}
