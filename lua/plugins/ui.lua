-- Plugins: UI

return {

  -----------------------------------------------------------------------------
  -- Snazzy tab/bufferline
  -- NOTE: This extends
  -- $XDG_DATA_HOME/nvim/lazy/LazyVim/lua/lazyvim/plugins/ui.lua
  {
    "akinsho/bufferline.nvim",
    dependencies = "nvim-tree/nvim-web-devicons",
    -- stylua: ignore
    keys = {
      { '<leader>tp', '<Cmd>BufferLinePick<CR>', desc = 'Tab Pick' },
      { '<M-[>', '<Cmd>BufferLineCyclePrev<CR>', desc = 'Tab Cycle Previous' },
      { '<M-]>', '<Cmd>BufferLineCycleNext<CR>', desc = 'Tab Cycle Next' },
      {'<leader>1', '<cmd>lua require("bufferline").go_to(1, true)<cr>', desc = 'Goto Tab 1'},
      {'<leader>2', '<cmd>lua require("bufferline").go_to(2, true)<cr>', desc = 'Goto Tab 2'},
      {'<leader>3', '<cmd>lua require("bufferline").go_to(3, true)<cr>', desc = 'Goto Tab 3'},
      {'<leader>4', '<cmd>lua require("bufferline").go_to(4, true)<cr>', desc = 'Goto Tab 4'},
      {'<leader>5', '<cmd>lua require("bufferline").go_to(5, true)<cr>', desc = 'Goto Tab 5'},
      {'<leader>6', '<cmd>lua require("bufferline").go_to(6, true)<cr>', desc = 'Goto Tab 6'},
      {'<leader>7', '<cmd>lua require("bufferline").go_to(7, true)<cr>', desc = 'Goto Tab 7'},
      {'<leader>8', '<cmd>lua require("bufferline").go_to(8, true)<cr>', desc = 'Goto Tab 8'},
      {'<leader>9', '<cmd>lua require("bufferline").go_to(9, true)<cr>', desc = 'Goto Tab 9'},
      {'<leader>$', '<cmd>lua require("bufferline").go_to(-1, true)<cr>', desc = 'Goto Tab'},
    },
  },

  {
    "xzbdmw/colorful-menu.nvim",
  },
  -----------------------------------------------------------------------------
  -- Replaces the UI for messages, cmdline and the popupmenu
  -- NOTE: This extends
  -- $XDG_DATA_HOME/nvim/lazy/LazyVim/lua/lazyvim/plugins/ui.lua
  {
    "noice.nvim",
    opts = {
      lsp = {
        override = {
          ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
          ["vim.lsp.util.stylize_markdown"] = true,
          ["cmp.entry.get_documentation"] = true,
        },
      },
      messages = {
        view_search = false,
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
      routes = {
        -- See :h ui-messages
        {
          filter = {
            event = "msg_show",
            any = {
              { find = "%d+L, %d+B" },
              { find = "^%d+ changes?; after #%d+" },
              { find = "^%d+ changes?; before #%d+" },
              { find = "^Hunk %d+ of %d+$" },
              { find = "^%d+ fewer lines;?" },
              { find = "^%d+ more lines?;?" },
              { find = "^%d+ line less;?" },
              { find = "^Already at newest change" },
              { kind = "wmsg" },
              { kind = "emsg", find = "E486" },
              { kind = "quickfix" },
            },
          },
          view = "mini",
        },
      },
    },
  },

  -----------------------------------------------------------------------------
  -- Collection of small QoL plugins
  -- NOTE: This extends
  -- $XDG_DATA_HOME/nvim/lazy/LazyVim/lua/lazyvim/plugins/ui.lua
  -- $XDG_DATA_HOME/nvim/lazy/LazyVim/lua/lazyvim/plugins/util.lua
  {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    ---@type snacks.Config
    opts = {
      input = { enabled = true },
      picker = {
        enabled = true,
        win = {
          input = {
            keys = {
              ["jj"] = { "<esc>", expr = true, mode = "i" },
              ["sv"] = "edit_split",
              ["sg"] = "edit_vsplit",
              ["st"] = "edit_tab",
              ["."] = "toggle_hidden",
              [","] = "toggle_ignored",
              ["e"] = "qflist",
              ["E"] = "loclist",
              ["K"] = "select_and_prev",
              ["J"] = "select_and_next",
              ["*"] = "select_all",
              ["<c-l>"] = { "preview_scroll_right", mode = { "i", "n" } },
              ["<c-h>"] = { "preview_scroll_left", mode = { "i", "n" } },
            },
          },
          list = {
            keys = {
              ["<c-l>"] = "preview_scroll_right",
              ["<c-h>"] = "preview_scroll_left",
            },
          },
          preview = {
            keys = {
              ["<c-h>"] = "focus_input",
              ["<c-l>"] = "cycle_win",
            },
          },
        },
      },
    },
    keys = {
      {
        "<leader><localleader>",
        function()
          Snacks.picker()
        end,
        mode = { "n", "x" },
        desc = "Pickers",
      },
      {
        "<localleader>i",
        function()
          Snacks.picker.icons()
        end,
        mode = { "n", "x" },
        desc = "Spellcheck",
      },
      {
        "<localleader>n",
        function()
          Snacks.picker.notifications()
        end,
        desc = "Notifications",
      },
      {
        "<localleader>u",
        function()
          Snacks.picker.spelling()
        end,
        mode = { "n", "x" },
        desc = "Spellcheck",
      },
      {
        "<localleader>/",
        function()
          Snacks.picker.search_history()
        end,
        mode = { "n", "x" },
        desc = "Search History",
      },
      {
        "<leader>gF",
        function()
          Snacks.picker.files({ pattern = vim.fn.expand("<cword>") })
        end,
        desc = "Find File",
      },
    },
  },
}
