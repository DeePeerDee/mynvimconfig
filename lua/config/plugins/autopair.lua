return {
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = function()
      require("nvim-autopairs").setup({
        check_ts = true, -- Enable Treesitter integration
        ts_config = {
          lua = { "string" }, -- Don't add pairs in lua string nodes
          javascript = { "template_string" },
        },
      })

      -- Integrate with nvim-cmp
      local cmp_autopairs = require("nvim-autopairs.completion.cmp")
      local cmp = require("cmp")
      cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    opts = {},
    ft = { "html", "javascript", "typescript", "markdown", "xml" },
  },
}
