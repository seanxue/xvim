-- plugin: symbols-outline.nvim
-- see: https://github.com/simrat39/symbols-outline.nvim
-- rafi settings

-- :h symbols-outline.txt
require("symbols-outline").setup({
  highlight_hovered_item = true,
  show_guides = true,
  auto_preview = false,
  position = "right",
  width = 30,
  keymaps = {
    close = { "<Esc>", "q" },
    goto_location = "<CR>",
    focus_location = "o",
    hover_symbol = "K",
    toggle_preview = "p",
    rename_symbol = "r",
    code_actions = "a",
    fold = "h",
    unfold = "l",
    fold_all = "W",
    unfold_all = "E",
    fold_reset = "R",
  },
  lsp_blacklist = {},
})

vim.cmd([[
	augroup user-symbols-outline
		autocmd!
		autocmd FileType Outline setlocal cursorline winhighlight=CursorLine:WildMenu
		autocmd WinEnter,BufEnter Outline setlocal cursorline
		autocmd WinLeave,BufLeave Outline setlocal nocursorline
	augroup END
]])
