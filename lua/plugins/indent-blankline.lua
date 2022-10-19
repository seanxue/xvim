-- indent-blankline
--

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"

local setup = function ()
  local indent = require("indent_blankline")
  indent.setup {
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
  }
end

return {
  setup = setup,
}
