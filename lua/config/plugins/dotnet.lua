return {
  {
    "seblyng/roslyn.nvim",
    ft = "cs",
    config = function()
      vim.lsp.config("roslyn", {
        capabilities = require("cmp_nvim_lsp").default_capabilities(),
        settings = {
          ["csharp|completion"] = {
            show_completion_items_from_unimported_namespaces = true,
            show_token_completion_items = true,
          },
          ["csharp|navigation"] = {
            enable_decompile_support = true,
          }
        }
      })

      require("roslyn").setup()
    end,
  },
}
