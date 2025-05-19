return {
  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "go", "gomod", "gosum", "gotmpl", "gowork" } },
  },

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
            gopls = {
              analyses = {
                fieldalignment = false,
                unusedvariable = true,
              },
            },
          },
        },
      },
    },
  },

  {
    "nvimtools/none-ls.nvim",
    optional = true,
    dependencies = {
      {
        "mason-org/mason.nvim",
        opts = {
          ensure_installed = { "goimports", "gofumpt", "goimports-reviser", "gomodifytags", "impl" },
        },
      },
    },
    opts = function(_, opts)
      local nls = require("null-ls")
      opts.sources = vim.list_extend(opts.sources or {}, {
        nls.builtins.code_actions.gomodifytags,
        nls.builtins.code_actions.impl,
        nls.builtins.formatting.goimports,
        nls.builtins.formatting.gofumpt,
      })
    end,
  },
}
