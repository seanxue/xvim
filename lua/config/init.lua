-- CodeCompanion chat buffer keymaps
local group = vim.api.nvim_create_augroup("codecompanion_keymaps", { clear = true })
vim.api.nvim_create_autocmd("FileType", {
  group = group,
  pattern = "codecompanion",
  callback = function(event)
    local buf = event.buf
    -- Ensure <CR> sends message in insert mode
    vim.keymap.set("i", "<CR>", function()
      local chat = require("codecompanion").buf_get_chat(buf)
      if chat then
        chat.chat:submit()
      end
    end, { buffer = buf, noremap = true, desc = "Send message" })
    -- <S-CR> for newline in insert mode (Shift+Enter)
    vim.keymap.set("i", "<S-CR>", "<CR>", { buffer = buf, noremap = true, desc = "Newline in CodeCompanion" })
  end,
})
