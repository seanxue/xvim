return {
  -- TODO: integrate with https://github.com/ravitemer/mcphub.nvim
  "yetone/avante.nvim",
  event = "VeryLazy",
  version = false, -- Never set this value to "*"! Never!
  opts = {
    behaviour = {
      enable_fastapply = true,
    },
    provider = "codebuddy",
    acp_providers = {
      ["tgmn"] = {
        command = "gemini-internal",
        args = { "--experimental-acp" },
      },
      ["codebuddy"] = {
        command = "codebuddy",
        args = { "--acp", "--model", "claude-opus-4.6-1m" },
        env = {
          CODEBUDDY_INTERNET_ENVIRONMENT = "iOA",
          CODEBUDDY_API_KEY = vim.env.CODEBUDDY_API_KEY,
        },
        timeout = 30000,
      },
    },
    providers = {
      minimax = {
        __inherited_from = "openai",
        api_key_name = "MINIMAX_API_KEY",
        endpoint = "https://api.minimax.chat/v1",
        model = "MiniMax-M2.7",
        timeout = 30000,
      },
      morph = {
        model = "morph-v3-large",
      },
    },
    mappings = {
      submit = {
        normal = "<CR>",
        insert = "<CR>",
      },
      toggle = {
        default = "<C-\\>",
      },
    },
    windows = {
      width = 40,
      edit = {
        start_insert = true,
      },
      ask = {
        floating = true,
        start_insert = true,
      },
    },
  },
  keys = {
    {
      "<C-\\>",
      function()
        local is_open = require("avante").is_sidebar_open()
        require("avante.api").toggle()
        if is_open then
          vim.schedule(function()
            vim.cmd("stopinsert")
          end)
        end
      end,
      mode = { "n", "i", "v" },
      desc = "avante: toggle",
    },
  },
  init = function()
    -- 进入 Avante 输出窗口时自动滚到底部
    vim.api.nvim_create_autocmd("BufEnter", {
      pattern = "*",
      callback = function()
        if vim.bo.filetype == "Avante" then
          vim.schedule(function()
            local win = vim.api.nvim_get_current_win()
            local buf = vim.api.nvim_win_get_buf(win)
            local last_line = vim.api.nvim_buf_line_count(buf)
            if last_line > 0 then
              vim.api.nvim_win_set_cursor(win, { last_line, 0 })
            end
          end)
        end
      end,
    })
  end,
  build = "make",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    "nvim-lua/plenary.nvim",
    "MunifTanjim/nui.nvim",
    --- The below dependencies are optional,
    "nvim-mini/mini.pick", -- for file_selector provider mini.pick
    "nvim-telescope/telescope.nvim", -- for file_selector provider telescope
    "ibhagwan/fzf-lua",
    "nvim-mini/mini.icons",
    "zbirenbaum/copilot.lua", -- for providers='copilot'
    {
      -- support for image pasting
      "HakonHarnes/img-clip.nvim",
      event = "VeryLazy",
      opts = {
        -- recommended settings
        default = {
          embed_image_as_base64 = false,
          prompt_for_file_name = false,
          drag_and_drop = {
            insert_mode = true,
          },
        },
      },
    },

    {
      -- Make sure to set this up properly if you have lazy=true
      "MeanderingProgrammer/render-markdown.nvim",
      opts = {
        file_types = { "markdown", "Avante" },
      },
      ft = { "markdown", "Avante" },
    },
  },
}