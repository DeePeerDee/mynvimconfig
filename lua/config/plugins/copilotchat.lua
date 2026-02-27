return {
  {
    "CopilotC-Nvim/CopilotChat.nvim",
    branch = "main", -- Ensure you're on the main branch
    cmd = { "CopilotChat", "CopilotChatToggle", "CopilotChatExplain" }, -- ADD THIS
    dependencies = {
      { "zbirenbaum/copilot.lua" }, -- Pulls from your other config
      { "nvim-lua/plenary.nvim" },
    },
    build = "make tiktoken",
    opts = {
      debug = false,
      show_help = "yes",
      -- Add a nice border to the chat window
      window = {
        layout = 'float',
        border = 'rounded',
      },
    },
    keys = {
      {
        "<leader>ccb",
        function()
          local input = vim.fn.input("Quick Chat: ")
          if input ~= "" then
            require("CopilotChat").ask(input, { selection = require("CopilotChat.select").buffer })
          end
        end,
        desc = "CopilotChat - Chat with current buffer",
      },
      { "<leader>cct", "<cmd>CopilotChatToggle<cr>", desc = "CopilotChat - Toggle" },
    },
  },
}
