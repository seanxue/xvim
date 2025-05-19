-- LSP: Extend LazyVim settings

return {

  -----------------------------------------------------------------------------
  -- Quickstart configurations for the Nvim LSP client
  -- NOTE: This extends
  -- $XDG_DATA_HOME/nvim/lazy/LazyVim/lua/lazyvim/plugins/lsp/init.lua
  -- $XDG_DATA_HOME/nvim/lazy/LazyVim/lua/lazyvim/plugins/lsp/keymaps.lua
  {
    "nvim-lspconfig",
    -- stylua: ignore
    opts = function()
      local keys = require('lazyvim.plugins.lsp.keymaps').get()
      vim.list_extend(keys, {
        { '<leader>cl', false },
        { '<c-k>', false, mode = 'i' },
        { '<leader>cli', vim.lsp.buf.incoming_calls, desc = 'Incoming calls' },
        { '<leader>clo', vim.lsp.buf.outgoing_calls, desc = 'Outgoing calls' },
        { '<leader>fwa', vim.lsp.buf.add_workspace_folder, desc = 'Show Workspace Folders' },
        { '<leader>fwr', vim.lsp.buf.remove_workspace_folder, desc = 'Remove Workspace Folder' },
        { '<leader>fwl', '<cmd>lua =vim.lsp.buf.list_workspace_folders()<CR>', desc = 'List Workspace Folders' },
      })
    end,
  },

  -----------------------------------------------------------------------------
  -- Portable package manager for Neovim
  -- NOTE: This extends
  -- $XDG_DATA_HOME/nvim/lazy/LazyVim/lua/lazyvim/plugins/lsp/init.lua
  {
    "mason-org/mason.nvim",
    opts = {
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
        border = "rounded",
      },
    },
  },
  {
    "mason-org/mason-lspconfig.nvim",
    opts = {
      ensure_installed = {
        "lua_ls",
      },
      automatic_enable = {
        "lua_ls",
        "vimls",
      },
    },
  },
}
