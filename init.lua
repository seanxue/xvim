-- Rafael Bodill's Neovim entry-point
-- https://github.com/rafi/vim-config

local config = require('rafi.config')
config.ensure_lazy()

-- Start lazy.nvim plugin manager.
require('lazy').setup(
	vim.tbl_extend('keep',
		config.user_lazy_opts(), {
			spec = {
				{ import = 'rafi.plugins' },
				{ import = 'rafi.plugins.extras.coding' },
				{ import = 'rafi.plugins.extras.diagnostics' },
				{ import = 'rafi.plugins.extras.editor' },
				{ import = 'rafi.plugins.extras.formatting' },
				{ import = 'rafi.plugins.extras.git' },
				{ import = 'rafi.plugins.extras.lang' },
				{ import = 'rafi.plugins.extras.linting' },
				{ import = 'rafi.plugins.extras.lsp' },
				{ import = 'rafi.plugins.extras.org' },
				{ import = 'rafi.plugins.extras.treesitter' },
				{ import = 'rafi.plugins.extras.ui' },

				-- This will load a custom user lua/plugins.lua or lua/plugins/*
				config.has_user_plugins() and { import = 'plugins' } or nil,
			},
			concurrency = vim.loop.available_parallelism() * 2,
			defaults = { lazy = true, version = false },
			dev = { path = config.path_join(vim.fn.stdpath('config'), 'dev') },
			install = { missing = true, colorscheme = {} },
			checker = { enabled = true, notify = false },
			change_detection = { notify = false },
			ui = { border = 'rounded' },
			diff = { cmd = 'terminal_git' },
			performance = {
				rtp = {
					disabled_plugins = {
						'gzip',
						'vimballPlugin',
						'matchit',
						'matchparen',
						'2html_plugin',
						'tarPlugin',
						-- 'netrwPlugin',
						'tutor',
						'zipPlugin',
					},
				},
			},
}))

config.setup()

-- Enjoy!
