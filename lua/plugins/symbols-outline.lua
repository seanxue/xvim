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
  autofold_depth = 3,
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
  symbols = {
    File = { icon = "", hl = "@text.uri" },
    Module = { icon = "", hl = "@namespace" },
    Namespace = { icon = "", hl = "@namespace" },
    Package = { icon = "", hl = "@namespace" },
    Class = { icon = "𝓒", hl = "@type" },
    Method = { icon = "ƒ", hl = "@method" },
    Property = { icon = "", hl = "@method" },
    Field = { icon = "", hl = "@field" },
    Constructor = { icon = "", hl = "@constructor" },
    Enum = { icon = "ℰ", hl = "@type" },
    Interface = { icon = "", hl = "@type" },
    Function = { icon = "", hl = "@function" },
    Variable = { icon = "", hl = "@constant" },
    Constant = { icon = "", hl = "@constant" },
    String = { icon = "𝓐", hl = "@string" },
    Number = { icon = "#", hl = "@number" },
    Boolean = { icon = "⊨", hl = "@boolean" },
    Array = { icon = "󰅪", hl = "@constant" },
    Object = { icon = "⦿", hl = "@type" },
    Key = { icon = "🔐", hl = "@type" },
    Null = { icon = "NULL", hl = "@type" },
    EnumMember = { icon = "", hl = "@field" },
    Struct = { icon = "𝓢", hl = "@type" },
    Event = { icon = "", hl = "@type" },
    Operator = { icon = "+", hl = "@operator" },
    TypeParameter = { icon = "𝙏", hl = "@parameter" },
    Component = { icon = "", hl = "@function" },
    Fragment = { icon = "", hl = "@constant" },
  },
})

vim.cmd([[
	augroup user-symbols-outline
		autocmd!
		autocmd FileType Outline setlocal cursorline winhighlight=CursorLine:WildMenu
		autocmd WinEnter,BufEnter Outline setlocal cursorline
		autocmd WinLeave,BufLeave Outline setlocal nocursorline
	augroup END
]])
