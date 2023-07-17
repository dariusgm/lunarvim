lvim.plugins = {
  {
    'wfxr/minimap.vim',
    build = "cargo install --locked code-minimap",
    -- cmd = {"Minimap", "MinimapClose", "MinimapToggle", "MinimapRefresh", "MinimapUpdateHighlight"},
    config = function()
      vim.cmd("let g:minimap_width = 10")
      vim.cmd("let g:minimap_auto_start = 1")
      vim.cmd("let g:minimap_auto_start_win_enter = 1")
    end,
  },
  {
    "windwp/nvim-ts-autotag",
    config = function()
      require("nvim-ts-autotag").setup()
    end,
  },
  {
    "JoosepAlviste/nvim-ts-context-commentstring",
    event = "BufRead",
  },
  {
    "mrjones2014/nvim-ts-rainbow",
  },
  {
    "metakirby5/codi.vim",
    cmd = "Codi",
  },
  -- You must install glow globally
  -- https://github.com/charmbracelet/glow
  -- yay -S glow
  {
    "npxbr/glow.nvim",
    ft = { "markdown" }
    -- build = "yay -S glow"
  },

  -- github Copilot integration
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({})
    end,
  },
  {
    "jackMort/ChatGPT.nvim",
    event = "VeryLazy",
    config = function()
      require("chatgpt").setup()
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope.nvim"
    }
  }
}

lvim.leader = "space"
lvim.builtin.treesitter.rainbow.enable = true
lvim.lsp.automatic_servers_installation = false
