lvim.plugins                            = {
  {
    -- Renders a minimap, same as in sublime text.
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
  -- ChatGPT integration
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
  },
  { "mfussenegger/nvim-dap-python" }
}
-- DAP Configuration

local dap                               = require('dap')

dap.adapters.python                     = {
  type = 'executable',
  command = 'python',
  args = { '-m', 'debugpy.adapter' },
}

dap.configurations.python               = {
  {
    type = 'python',
    request = 'launch',
    name = "Launch file",
    program = "${file}",
    pythonPath = function()
      local handle = io.popen('pyenv global 2>&1') -- also capture stderr
      if handle then
        local pyenv_version = handle:read("*a")
        handle:close()

        -- remove newline character
        pyenv_version = pyenv_version:gsub("\n", "")

        -- resolve '~' to home directory
        local home_dir = os.getenv("HOME")
        local pyenv_path = home_dir .. "/.pyenv/versions/" .. pyenv_version .. "/bin/python3"
        return pyenv_path
      else
        -- 'pyenv global' command failed or 'pyenv' is not available, return fallback path
        return "/usr/bin/python"
      end
    end,
  },

}

dap.adapters.sh                         = {
  type = "executable",
  command = 'bash',
  args = { '/usr/share/bashdb/command/debug.sh' }

}
local BASH_DEBUG_ADAPTER_BIN            = lvim.builtin.mason.install_root_dir ..
    '/packages/bash-debug-adapter/bash-debug-adapter'
local BASHDB_DIR                        = lvim.builtin.mason.install_root_dir ..
    '/packages/bash-debug-adapter/extension/bashdb_dir'
dap.configurations.sh                   = {
  {
    name = "Launch Bash debugger",
    type = "sh",
    request = "launch",
    program = "${file}",
    cwd = "${fileDirname}",
    pathBashdb = BASH_DEBUG_ADAPTER_BIN,
    pathBashdbLib = BASHDB_DIR,
    pathBash = "bash",
    pathCat = "cat",
    pathMkfifo = "mkfifo",
    pathPkill = "pkill",
    env = {},
    args = {},
    -- showDebugOutput = true,
    -- trace = true,
  }
}
lvim.format_on_save                     = true
lvim.leader                             = "space"
lvim.builtin.treesitter.rainbow.enable  = true
lvim.lsp.automatic_servers_installation = false
