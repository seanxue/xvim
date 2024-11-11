return {
	{
		"williamboman/mason.nvim",
		opts = function(_, opts)
			vim.list_extend(opts.ensure_installed, {
				"ruff",
			})
		end,
	},

	{
		"jose-elias-alvarez/null-ls.nvim",
		optional = true,
		opts = function(_, opts)
			if type(opts.sources) == "table" then
				local nls = require("null-ls")
				table.insert(opts.sources, nls.builtins.formatting.ruff)
			end
		end,
	},
}
