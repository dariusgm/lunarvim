vim.opt.timeoutlen = 100
lvim.plugins = {}
-- options
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

