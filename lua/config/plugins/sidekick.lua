return {
  {
    "folke/sidekick.nvim",
    config = function()
      require("sidekick").setup({
        cli = {
          mux = {
            backend = "tmux",
            enabled = true,
          },
        }
      })
    end,
    keys = {
      {
        "<tab>",
        function()
          -- if there is a next edit, jump to it, otherwise apply it if any
          if not require("sidekick").nes_jump_or_apply() then
            return "<tab>" -- fallback to normal tab
          end
        end,
        expr = true,
        desc = "goto/apply next edit suggestion",
      },
      {
        "<c-.>",
        function() require("sidekick.cli").toggle() end,
        desc = "sidekick toggle",
        mode = { "n", "t", "i", "x" },
      },
      {
        "<leader>aa",
        function() require("sidekick.cli").toggle() end,
        desc = "sidekick toggle cli",
      },
      {
        "<leader>as",
        function() require("sidekick.cli").select() end,
        -- or to select only installed tools:
        -- require("sidekick.cli").select({ filter = { installed = true } }),
        desc = "select cli",
      },
      {
        "<leader>ad",
        function() require("sidekick.cli").close() end,
        desc = "detach a cli session",
      },
      {
        "<leader>at",
        function() require("sidekick.cli").send({ msg = "{this}" }) end,
        mode = { "x", "n" },
        desc = "send this",
      },
      {
        "<leader>af",
        function() require("sidekick.cli").send({ msg = "{file}" }) end,
        desc = "send file",
      },
      {
        "<leader>av",
        function() require("sidekick.cli").send({ msg = "{selection}" }) end,
        mode = { "x" },
        desc = "send visual selection",
      },
      {
        "<leader>ap",
        function() require("sidekick.cli").prompt() end,
        mode = { "n", "x" },
        desc = "sidekick select prompt",
      },
      {
        "<leader>ac",
        function() require("sidekick.cli").toggle({ name = "copilot", focus = true }) end,
        desc = "sidekick toggle copilot",
      },
      {
        "<leader>ag",
        function() require("sidekick.cli").toggle({ name = "gemini", focus = true }) end,
        desc = "sidekick toggle gemini",
      },
    },
  }
}
