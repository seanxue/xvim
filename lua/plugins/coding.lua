-- Plugins: Coding

local has_words_before = function()
  local col = vim.api.nvim_win_get_cursor(0)[2]
  if col == 0 then
    return false
  end
  local line = vim.api.nvim_get_current_line()
  return line:sub(col, col):match("%s") == nil
end

return {

  -- workspace
  {
    "natecraddock/workspaces.nvim",
    lazy = false,
    opts = {},
    config = function(_, _)
      require("workspaces").setup()
      require("telescope").load_extension("workspaces")
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    lazy = false,
    build = ":TSUpdate",
    opts = {
      ensure_installed = {
        "go",
        "gomod",
        "gosum",
        "gotmpl",
        "gowork",
        "c",
        "lua",
        "vim",
        "vimdoc",
        "query",
        "python",
        "shell",
        "markdown",
        "markdown_inline",
      },
    },
  },

  -----------------------------------------------------------------------------
  -- Code completion
  -- NOTE: This extends
  -- $XDG_DATA_HOME/nvim/lazy/LazyVim/lua/lazyvim/plugins/extras/coding/blink.lua
  {
    "Saghen/blink.cmp",
    optional = true,
    version = "1.*",
    dependencies = {
      "Kaiser-Yang/blink-cmp-avante",
      "rafamadriz/friendly-snippets",
    },
    sources = {
      -- Add 'avante' to the list
      default = { "avante", "lsp", "path", "luasnip", "buffer" },
      providers = {
        avante = {
          module = "blink-cmp-avante",
          name = "Avante",
          opts = {
            -- options for blink-cmp-avante
          },
        },
      },
    },
    opts = {
      completion = {
        keyword = { range = "prefix" },
        ghost_text = { enabled = true },
        menu = {
          draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
              label = {
                text = function(ctx)
                  return require("colorful-menu").blink_components_text(ctx)
                end,
                highlight = function(ctx)
                  return require("colorful-menu").blink_components_highlight(ctx)
                end,
              },
            },
          },
        },
        list = { selection = { preselect = false }, cycle = { from_top = false } },
      },
      keymap = {
        -- see https://cmp.saghen.dev/recipes#emacs-behavior
        preset = "none",

        ["<Tab>"] = {
          function(cmp)
            if has_words_before() then
              return cmp.insert_next()
            end
          end,
          "fallback",
        },
        ["<S-Tab>"] = { "insert_prev" },

        ["<C-j>"] = { "select_next", "fallback" },
        ["<C-k>"] = { "select_prev", "fallback" },
        ["<C-d>"] = { "select_next", "fallback" },
        ["<C-u>"] = { "select_prev", "fallback" },
      },
    },
  },

  -----------------------------------------------------------------------------
  -- Lightweight yet powerful formatter plugin
  -- NOTE: This extends
  -- $XDG_DATA_HOME/nvim/lazy/LazyVim/lua/lazyvim/plugins/formatting.lua
  {
    "stevearc/conform.nvim",
    -- stylua: ignore
    keys = {
      { '<leader>cic', '<cmd>ConformInfo<CR>', silent = true, desc = 'Conform Info' },
    },
  },

  -----------------------------------------------------------------------------
  -- Asynchronous linter plugin
  -- NOTE: This extends
  -- $XDG_DATA_HOME/nvim/lazy/LazyVim/lua/lazyvim/plugins/linting.lua
  {
    "mfussenegger/nvim-lint",
    keys = {
      {
        "<leader>cin",
        function()
          vim.notify(vim.inspect(require("lint").linters[vim.bo.filetype]))
        end,
        silent = true,
        desc = "Linter Info",
      },
    },
  },

  -----------------------------------------------------------------------------
  -- Fast and feature-rich surround actions
  {
    "nvim-mini/mini.surround",
    version = "*",
    opts = {
      mappings = {
        add = "sa", -- Add surrounding in Normal and Visual modes
        delete = "ds", -- Delete surrounding
        find = "gzf", -- Find surrounding (to the right)
        find_left = "gzF", -- Find surrounding (to the left)
        highlight = "gzh", -- Highlight surrounding
        replace = "cs", -- Replace surrounding
        update_n_lines = "gzn", -- Update `n_lines`
      },
    },
  },

  -----------------------------------------------------------------------------
  -- Powerful line and block-wise commenting
  {
    "numToStr/Comment.nvim",
    dependencies = { "JoosepAlviste/nvim-ts-context-commentstring" },
    -- stylua: ignore
    keys = {
      { '<leader>V', '<Plug>(comment_toggle_blockwise_current)', mode = 'n', desc = 'Comment' },
      { '<leader>V', '<Plug>(comment_toggle_blockwise_visual)', mode = 'x', desc = 'Comment' },
    },
    opts = function(_, opts)
      local ok, tcc = pcall(require, "ts_context_commentstring.integrations.comment_nvim")
      if ok then
        opts.pre_hook = tcc.create_pre_hook()
      end
    end,
  },

  -----------------------------------------------------------------------------
  -- Trailing whitespace highlight and remove
  {
    "nvim-mini/mini.trailspace",
    event = { "BufReadPost", "BufNewFile" },
    -- stylua: ignore
    keys = {
      { '<leader>cw', '<cmd>lua MiniTrailspace.trim()<CR>', desc = 'Erase Whitespace' },
    },
    opts = {},
  },
}
