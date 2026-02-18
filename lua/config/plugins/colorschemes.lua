return {
	{
		"folke/tokyonight.nvim",
		lazy = false,
		priority = 1000,
		config = function()
		end,
	},
	{
		"catppuccin/nvim",
		lazy = false,
		priority = 1000,
		config = function()
		end,
	},
	{
		"rebelot/kanagawa.nvim",
		lazy = false,
		priority = 1000,
		config = function()
		end,
	},
  {
    "navarasu/onedark.nvim",
    lazy = false,
    priority = 1000,
    config = function()
    end,
  },
  {
    "projekt0n/github-nvim-theme",
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("github_dark_default")
    end,
  },
}

