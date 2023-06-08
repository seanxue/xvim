-- gopls
--
local util = require("lspconfig/util")
local lastRootPath = nil
local gopath = os.getenv("GOPATH")
if gopath == nil then
  gopath = ""
end
local gopathmod = gopath .. "/pkg/mod"

local function formatter()
  local clients = vim.lsp.get_active_clients()
  for _, client in pairs(clients) do
    local params = vim.lsp.util.make_range_params(nil, client.offset_encoding)
    params.context = { only = { "source.organizeImports" } }

    local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 5000)
    for _, res in pairs(result or {}) do
      for _, r in pairs(res.result or {}) do
        if r.edit then
          vim.lsp.util.apply_workspace_edit(r.edit, client.offset_encoding)
        else
          vim.lsp.buf.execute_command(r.command)
        end
      end
    end
  end
end

local config = {
  cmd = { "gopls" },
  filetypes = { "go", "gomod" },
  root_dir = function(fname)
    local fullpath = vim.fn.fnamemodify(fname, ":p")
    if lastRootPath ~= nil and string.find(fullpath, gopathmod) then
      return lastRootPath
    end
    lastRootPath = util.root_pattern("go.mod", ".git")(fname)
    return lastRootPath
  end,
  settings = {
    -- https://github.com/golang/tools/blob/master/gopls/doc/settings.md
    gopls = {
      staticcheck = true,
      gofumpt = true,
      linksInHover = true,
      -- https://github.com/golang/tools/blob/master/gopls/doc/analyzers.md
      analyses = {
        fillreturns = true,
        nonewvars = true,
        undeclaredname = true,
        unusedparams = false,
        ST1000 = false,
        ST1005 = false,
      },
    },
  },
  init_options = {
    usePlaceholders = true,
    completeUnimported = true,
  },
  formatter = formatter,
}

return {
  config = function()
    vim.api.nvim_create_autocmd("BufWritePre", { pattern = { "*.go" }, callback = formatter })
    return config
  end,
}