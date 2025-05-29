-- lazy.nvim initialization

-- print("seanxue initialization lazyvim")

-- Clone lazy.nvim if not already installed.
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
vim.uv = vim.uv or vim.loop
if not vim.uv.fs_stat(lazypath) then
  print("Installing lazy.nvim…")
  -- stylua: ignore
  vim.fn.system({ 'git', 'clone', '--filter=blob:none', 'https://github.com/folke/lazy.nvim.git', '--branch=stable', lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { "Press any key to exit...", "WarningMsg" },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end
vim.opt.rtp:prepend(lazypath)

vim.g.lazyvim_check_order = false

-- Start lazy.nvim plugin manager.
require("lazy").setup({
  spec = {
    -- add LazyVim and import its plugins
    { "LazyVim/LazyVim", import = "lazyvim.plugins" },
    -- import/override with your plugins
    { import = "plugins" },
    { import = "plugins.extras.lang" },
  },
  defaults = { lazy = true, version = "*" },
  install = { colorscheme = { "solarized" } },
  checker = { enabled = true, notify = false },
  ui = {
    size = { width = 0.8, height = 0.85 },
    border = "rounded",
    wrap = false,
  },
  performance = {
    rtp = {
      disabled_plugins = {
        "gzip",
        "vimballPlugin",
        "matchit",
        "matchparen",
        "2html_plugin",
        "tohtml",
        "tarPlugin",
        "netrwPlugin",
        "tutor",
        "zipPlugin",
      },
    },
  },
})
