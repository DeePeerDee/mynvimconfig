return {
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    config = function()
      require("nvim-treesitter").setup({
        ensure_installed = {
          "lua",
          "python",
          "typescript",
          "javascript",
          "html",
          "css",
          "c",
          "cpp",
          "rust",
          "java",
          "jsx",
          "tsx",
          "json",
          "xml",
          "yaml",
          "kotlin",
          "groovy",
          "markdown",
          "markdown_inline",
          "go",
          "gomod",
          "gowork",
          "gosum",
          "c_sharp",
          "ruby",
          "php",
      },
        highlight = {
          enable = true,
          additional_vim_regex_highlighting = false,
        },
        indent = { enable = true },
      })
    end,
  }
}
