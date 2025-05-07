return {
	{
		'williamboman/mason.nvim',
		opts = function(_, opts)
			table.insert(opts.ensure_installed, 'proselint')
		end,
	},
	{
		'nvimtools/none-ls.nvim',
		optional = true,
		opts = function(_, opts)
			opts.sources = opts.sources or {}
			local nls = require('null-ls')
			local source = nls.builtins.diagnostics.proselint.with({
				diagnostics_postprocess = function(diagnostic)
					diagnostic.severity = vim.diagnostic.severity.HINT
				end,
			})

			table.insert(opts.sources, source)
		end,
	},
}
