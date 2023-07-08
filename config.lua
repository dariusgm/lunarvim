vim.opt.timeoutlen = 100
lvim.plugins = {
  { "nvim-treesitter/nvim-treesitter-textobjects"},
  { "nvim-treesitter/playground" },
  {
      "jay-babu/mason-nvim-dap.nvim",
      opts = {
        ensure_installed = { "python" }
      }
    },
}
-- setup treesitter
require('nvim-treesitter.configs').setup {
  ensure_installed = "all", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
  },
}

-- DAP

-- dap
local dap = require('dap')
dap.adapters.python = {
  type = 'executable';
  command = '/usr/local/bin/python';
  args = { '-m', 'debugpy.adapter' };
}

dap.configurations.python = {
  {
    type = 'python';
    request = 'launch';
    name = "Launch file";
    program = "${file}";
    pythonPath = function()
      local cwd = vim.fn.getcwd()
      if vim.fn.glob(cwd .. '/venv/bin/python') ~= '' then
        return cwd .. '/venv/bin/python'
      elseif vim.fn.glob(cwd .. '/.venv/bin/python') ~= '' then
        return cwd .. '/.venv/bin/python'
      else
        return '/usr/local/bin/python'
      end
    end;
  },
}

-- misc options
lvim.log.level = "info"
lvim.leader = "space"
lvim.format_on_save = true
lvim.lint_on_save = true
lvim.builtin.gitsigns.active = true
lvim.builtin.breadcrumbs.active = true
-- highlight/match brackets
lvim.builtin.treesitter.matchup.enable = true

-- automatically update html tags when editing
lvim.builtin.treesitter.autotag.enable = true

-- enable incremental selection with <CR> and <tab>/<s-tab>
lvim.builtin.treesitter.incremental_selection = {
	module_path = "nvim-treesitter.incremental_selection",
	enable = true,
	keymaps = {
		init_selection = "<CR>",
		node_incremental = "<CR>",
		node_decremental = "<TAB>",
		scope_incremental = "<S-TAB>",
	},
	is_supported = function()
		return true
	end,
}


lvim.builtin.project.active = false

