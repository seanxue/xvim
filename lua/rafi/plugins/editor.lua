-- Plugins: Editor
-- https://github.com/rafi/vim-config

local is_windows = vim.loop.os_uname().sysname == "Windows_NT"

return {

	-----------------------------------------------------------------------------
	{ "nmac427/guess-indent.nvim", lazy = false, priority = 50, config = true },
	{ "tweekmonster/helpful.vim", cmd = "HelpfulVersion" },
	{ "lambdalisue/suda.vim", event = "BufRead" },

	-----------------------------------------------------------------------------
	{
		"christoomey/vim-tmux-navigator",
		lazy = false,
		cond = not is_windows,
		-- stylua: ignore
		keys = {
			{ '<C-h>', '<cmd>TmuxNavigateLeft<CR>', mode = { 'n', 't' }, silent = true, desc = 'Jump to left pane' },
			{ '<C-j>', '<cmd>TmuxNavigateDown<CR>', mode = { 'n', 't' }, silent = true, desc = 'Jump to lower pane' },
			{ '<C-k>', '<cmd>TmuxNavigateUp<CR>', mode = { 'n', 't' }, silent = true, desc = 'Jump to upper pane' },
			{ '<C-l>', '<cmd>TmuxNavigateRight<CR>', mode = { 'n', 't' }, silent = true, desc = 'Jump to right pane' },
		},
		init = function()
			vim.g.tmux_navigator_no_mappings = true
		end,
	},

	-----------------------------------------------------------------------------
	{
		"olimorris/persisted.nvim",
		lazy = false,
		opts = {
			autoload = true,
			autosave = true,
			use_git_branch = true,
			ignored_dirs = { "/usr", "/opt", "~/.cache", vim.env.TMPDIR or "/tmp" },
		},
		config = function(_, opts)
			if vim.g.in_pager_mode or vim.env.GIT_EXEC_PATH ~= nil then
				-- Do not autoload if stdin has been provided, or git commit session.
				opts.autoload = false
				opts.autosave = false
			end
			require("persisted").setup(opts)
		end,
	},

	-----------------------------------------------------------------------------
	{
		"RRethy/vim-illuminate",
		event = { "BufReadPost", "BufNewFile" },
		opts = {
			delay = 200,
			under_cursor = false,
			modes_allowlist = { "n", "no", "nt" },
			filetypes_denylist = {
				"DiffviewFileHistory",
				"DiffviewFiles",
				"SidebarNvim",
				"fugitive",
				"git",
				"minifiles",
				"neo-tree",
			},
		},
		keys = {
			{ "]r", desc = "Next Reference" },
			{ "[r", desc = "Prev Reference" },
		},
		config = function(_, opts)
			require("illuminate").configure(opts)

			local function map(key, dir, buffer)
				vim.keymap.set("n", key, function()
					require("illuminate")["goto_" .. dir .. "_reference"](false)
				end, {
					desc = dir:sub(1, 1):upper() .. dir:sub(2) .. " Reference",
					buffer = buffer,
				})
			end

			map("]r", "next")
			map("[r", "prev")

			-- also set it after loading ftplugins, since a lot overwrite [[ and ]]
			vim.api.nvim_create_autocmd("FileType", {
				group = vim.api.nvim_create_augroup("rafi_illuminate", {}),
				callback = function()
					local buffer = vim.api.nvim_get_current_buf()
					map("]r", "next", buffer)
					map("[r", "prev", buffer)
				end,
			})
		end,
	},

	-----------------------------------------------------------------------------
	{
		"mbbill/undotree",
		cmd = "UndotreeToggle",
		keys = {
			{ "<Leader>gu", "<cmd>UndotreeToggle<CR>", desc = "Undo Tree" },
		},
	},

	-----------------------------------------------------------------------------
	{
		"ggandor/flit.nvim",
		keys = function()
			local ret = {}
			for _, key in ipairs({ "f", "F", "t", "T" }) do
				ret[#ret + 1] = { key, mode = { "n", "x", "o" }, desc = key }
			end
			return ret
		end,
		opts = { labeled_modes = "nx" },
	},

	-----------------------------------------------------------------------------
	{
		"ggandor/leap.nvim",
		-- stylua: ignore
		keys = {
			{ 'ss', '<Plug>(leap-forward-to)', mode = { 'n', 'x', 'o' }, desc = 'Leap forward to' },
			{ 'sS', '<Plug>(leap-backward-to)', mode = { 'n', 'x', 'o' }, desc = 'Leap backward to' },
			{ 'SS', '<Plug>(leap-from-window)', mode = { 'n', 'x', 'o' }, desc = 'Leap from windows' },
		},
		config = true,
	},

	-----------------------------------------------------------------------------
	{
		"kana/vim-niceblock",
		-- stylua: ignore
		keys = {
			{ 'I',  '<Plug>(niceblock-I)',  silent = true, mode = 'x', desc = 'Blockwise Insert' },
			{ 'gI', '<Plug>(niceblock-gI)', silent = true, mode = 'x', desc = 'Blockwise Insert' },
			{ 'A',  '<Plug>(niceblock-A)',  silent = true, mode = 'x', desc = 'Blockwise Append' },
		},
		init = function()
			vim.g.niceblock_no_default_key_mappings = 0
		end,
	},

	-----------------------------------------------------------------------------
	{
		"haya14busa/vim-edgemotion",
		-- stylua: ignore
		keys = {
			{ 'gj', '<Plug>(edgemotion-j)', mode = { 'n', 'x' }, desc = 'Move to bottom edge' },
			{ 'gk', '<Plug>(edgemotion-k)', mode = { 'n', 'x' }, desc = 'Move to top edge' },
		},
	},

	-----------------------------------------------------------------------------
	{
		"folke/zen-mode.nvim",
		cmd = "ZenMode",
		keys = {
			{ "<Leader>zz", "<cmd>ZenMode<CR>", noremap = true, desc = "Zen Mode" },
		},
		opts = {
			plugins = {
				gitsigns = { enabled = true },
				tmux = { enabled = vim.env.TMUX ~= nil },
			},
		},
	},

	-----------------------------------------------------------------------------
	{
		"folke/which-key.nvim",
		event = "VeryLazy",
		opts = {
			win = {
				wo = { winblend = 10 },
			},
			spec = {
				{
					mode = { "n", "v" },
					{ ";", group = "+telescope" },
					{ ";d", group = "+lsp/todo" },
					{ "g", group = "+goto" },
					{ "gz", group = "+surround" },
					{ "]", group = "+next" },
					{ "[", group = "+prev" },
					{ "<leader>b", group = "+buffer" },
					{ "<leader>c", group = "+code" },
					{ "<leader>g", group = "+git" },
					{ "<leader>h", group = "+hunks" },
					{ "<leader>s", group = "+search" },
					{ "<leader>t", group = "+toggle/tools" },
					{ "<leader>u", group = "+ui" },
					{ "<leader>x", group = "+diagnostics/quickfix" },
					{ "<leader>z", group = "+notes" },
				},
			},
		},
	},

	-----------------------------------------------------------------------------
	{
		"folke/todo-comments.nvim",
		dependencies = "nvim-telescope/telescope.nvim",
		-- stylua: ignore
		keys = {
			{ ']t', function() require('todo-comments').jump_next() end, desc = 'Next todo comment' },
			{ '[t', function() require('todo-comments').jump_prev() end, desc = 'Previous todo comment' },
			{ '<LocalLeader>dt', '<cmd>TodoTelescope<CR>', desc = 'todo' },
			{ '<leader>xt', '<cmd>TodoTrouble<CR>', desc = 'Todo (Trouble)' },
			{ '<leader>xT', '<cmd>TodoTrouble keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme (Trouble)' },
			{ '<leader>st', '<cmd>TodoTelescope<cr>', desc = 'Todo' },
			{ '<leader>sT', '<cmd>TodoTelescope keywords=TODO,FIX,FIXME<cr>', desc = 'Todo/Fix/Fixme' },
		},
		opts = { signs = false },
	},

	-----------------------------------------------------------------------------
	{
		"folke/trouble.nvim",
		dependencies = { "nvim-tree/nvim-web-devicons" },
		cmd = { "Trouble" },
		opts = {},
		-- stylua: ignore
		keys = {
			{ '<leader>e', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Document Diagnostics' },
			{ '<leader>r', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Workspace Diagnostics' },
			{ '<leader>xx', '<cmd>Trouble diagnostics toggle focus=true filter.buf=0<CR>', desc = 'Document Diagnostics' },
			{ '<leader>xX', '<cmd>Trouble diagnostics toggle focus=true<CR>', desc = 'Workspace Diagnostics' },
			{ '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
			{ '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
			{
				'[q',
				function()
					if require('trouble').is_open() then
						require('trouble').previous({ skip_groups = true, jump = true })
					else
						vim.cmd.cprev()
					end
				end,
				desc = 'Previous trouble/quickfix item',
			},
			{
				']q',
				function()
					if require('trouble').is_open() then
						require('trouble').next({ skip_groups = true, jump = true })
					else
						vim.cmd.cnext()
					end
				end,
				desc = 'Next trouble/quickfix item',
			},
		},
	},

	-----------------------------------------------------------------------------
	{
		"akinsho/toggleterm.nvim",
		cmd = "ToggleTerm",
		keys = {
			{
				"<C-_>",
				mode = { "n", "t" },
				silent = true,
				function()
					local venv = vim.b["virtual_env"]
					local term = require("toggleterm.terminal").Terminal:new({
						env = venv and { VIRTUAL_ENV = venv } or nil,
						count = vim.v.count > 0 and vim.v.count or 1,
					})
					term:toggle()
				end,
				desc = "Toggle terminal",
			},
		},
		opts = {
			open_mapping = false,
			float_opts = {
				border = "curved",
			},
		},
	},

	-----------------------------------------------------------------------------
	{
		"hedyhli/outline.nvim",
		lazy = true,
		cmd = { "Outline", "OutlineOpen" },
		keys = {
			{ "<leader>o", "<cmd>Outline<CR>", desc = "Toggle outline" },
		},
		opts = {
			outline_window = {
				auto_jump = true,
			},
			symbol_folding = {
				autofold_depth = 1,
				auto_unfold = {
					hovered = true,
				},
			},
		},
	},

	-----------------------------------------------------------------------------
	{
		"s1n7ax/nvim-window-picker",
		event = "VeryLazy",
		keys = function(_, keys)
			local pick_window = function()
				local picked_window_id = require("window-picker").pick_window()
				if picked_window_id ~= nil then
					vim.api.nvim_set_current_win(picked_window_id)
				end
			end

			local swap_window = function()
				local picked_window_id = require("window-picker").pick_window()
				if picked_window_id ~= nil then
					local current_winnr = vim.api.nvim_get_current_win()
					local current_bufnr = vim.api.nvim_get_current_buf()
					local other_bufnr = vim.api.nvim_win_get_buf(picked_window_id)
					vim.api.nvim_win_set_buf(current_winnr, other_bufnr)
					vim.api.nvim_win_set_buf(picked_window_id, current_bufnr)
				end
			end

			local mappings = {
				{ "-", pick_window, desc = "Pick window" },
				{ "sp", pick_window, desc = "Pick window" },
				{ "sw", swap_window, desc = "Swap picked window" },
			}
			return vim.list_extend(mappings, keys)
		end,
		opts = {
			hint = "floating-big-letter",
			show_prompt = false,
			filter_rules = {
				include_current_win = true,
				bo = {
					filetype = { "notify", "noice", "incline", "neo-tree", "outline" },
					buftype = {},
				},
			},
		},
	},

	-----------------------------------------------------------------------------
	-- {
	-- 	"rest-nvim/rest.nvim",
	-- 	ft = "http",
	-- 	keys = {
	-- 		{ "<Leader>mh", "<Plug>RestNvim", desc = "Execute HTTP request" },
	-- 	},
	-- 	opts = { skip_ssl_verification = true },
	-- 	config = function(_, opts)
	-- 		require("rest-nvim").setup(opts)
	-- 	end,
	-- },

	-----------------------------------------------------------------------------
	{
		"nvim-pack/nvim-spectre",
		-- stylua: ignore
		keys = {
			{ '<Leader>sp', function() require('spectre').toggle() end, desc = 'Spectre', },
			{ '<Leader>sp', function() require('spectre').open_visual({ select_word = true }) end, mode = 'x', desc = 'Spectre Word' },
		},
		opts = {
			mapping = {
				["toggle_gitignore"] = {
					map = "tg",
					cmd = "<cmd>lua require('spectre').change_options('gitignore')<CR>",
					desc = "toggle gitignore",
				},
			},
			find_engine = {
				["rg"] = {
					cmd = "rg",
					args = {
						"--color=never",
						"--no-heading",
						"--with-filename",
						"--line-number",
						"--column",
						"--ignore",
					},
					options = {
						["gitignore"] = {
							value = "--no-ignore",
							icon = "[G]",
							desc = "gitignore",
						},
					},
				},
			},
			default = {
				find = {
					cmd = "rg",
					options = { "ignore-case", "hidden", "gitignore" },
				},
			},
		},
	},

	-----------------------------------------------------------------------------
	{
		"echasnovski/mini.bufremove",
		opts = {},
		-- stylua: ignore
		keys = {
			{ '<leader>bd', function() require('mini.bufremove').delete(0, false) end, desc = 'Delete Buffer', },
		},
	},

	-----------------------------------------------------------------------------
	{
		"mzlogin/vim-markdown-toc",
		cmd = { "GenTocGFM", "GenTocRedcarpet", "GenTocGitLab", "UpdateToc" },
		ft = "markdown",
		init = function()
			vim.g.vmt_auto_update_on_save = 0
		end,
	},

	{
		"junegunn/vim-easy-align",
		keys = {
			{ "ga", "<Plug>(EasyAlign)", mode = { "n", "x" }, desc = "start interactive EasyAlign" },
		},
	},
}
