return {
	{
		"luukvbaal/statuscol.nvim",
		event = "BufReadPost",
		opts = function()
			local builtin = require("statuscol.builtin")
			return {
				setopt = true,
				relculright = true,
				segments = {
					{ text = { builtin.lnumfunc }, click = "v:lua.ScLa" },
					{ text = { "%s" }, click = "v:lua.ScSa" },
					{ text = { builtin.foldfunc }, click = "v:lua.ScFa" },
				},
			}
		end,
	},
}
