-- print("seanxue loading " .. vim.fn.expand("%:h"))

return {
  desc = "Imports Go lang extras and adds more tools.",
  recommended = function()
    return LazyVim.extras.wants({
      ft = { "go", "gomod", "gowork", "gotmpl" },
      root = { "go.work", "go.mod" },
    })
  end,

  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        gopls = {
          settings = {
            gopls = {
              hints = {
                assignVariableTypes = false,
                compositeLiteralFields = false,
                compositeLiteralTypes = false,
                functionTypeParameters = false,
                parameterNames = false,
                rangeVariableTypes = false,
              },
            },
          },
        },
      },
    },
  },

  {
    "nvim-treesitter/nvim-treesitter",
    opts = { ensure_installed = { "go", "gomod", "gosum", "gotmpl", "gowork" } },
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
