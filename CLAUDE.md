# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is **xvim**, a Neovim configuration built on LazyVim v8 (Lua-based). It uses lazy.nvim as the plugin manager and requires Neovim >= 0.8.0.

## Common Commands

```bash
make install          # Bootstrap: create dirs + update Treesitter parsers
make update           # Full update: pull repo, plugins, Mason packages
make update-plugins   # Update Treesitter parsers only (nvim --headless -c 'TSUpdate' -c qa)
make update-mason     # Update Mason package registry
make test             # Verify Neovim version >= 0.8.0
make venv             # Create Python virtualenv for pynvim (pyenv or venv)
```

## Architecture

**Entry point:** `init.lua` loads `lua/config/lazy.lua`, which bootstraps lazy.nvim and loads LazyVim + local plugins.

### Config Layer (`lua/config/`)

All files here extend LazyVim defaults:

- **lazy.lua** - Plugin manager setup. Loads specs from `lazyvim.plugins`, `plugins/`, and `plugins/extras/lang/`. Disables 10 builtin Vim plugins for performance.
- **options.lua** - Leader=Space, LocalLeader=`;`. TextWidth=120, no relative numbers, cmdheight=0, mouse in normal/visual only. Disables python/perl/ruby/node providers. Custom filetype mappings (Brewfile, justfile, helmfile, etc.).
- **keymaps.lua** - Extensive custom keymaps (~500 lines). Picker shortcuts via localleader, window/buffer management, git operations, code editing helpers.
- **autocmds.lua** - Cursor restore, close-with-q filetypes, spell for text files, sudo safety.

### Plugin Layer (`lua/plugins/`)

Each file returns a lazy.nvim spec table extending or overriding LazyVim defaults:

| File | Purpose |
|------|---------|
| `colorscheme.lua` | Solarized theme |
| `coding.lua` | Completion (blink.cmp), snippets (LuaSnip), pairs, surround |
| `editor.lua` | Which-key, persistence, grug-far, marks, treesitter |
| `lsp.lua` | nvim-lspconfig keys, Mason, mason-lspconfig, mason-tool-installer |
| `telescope.lua` | Telescope pickers and extensions |
| `neo-tree.lua` | File explorer config |
| `git.lua` | Gitsigns, diffview |
| `ui.lua` | Noice, bufferline, lualine, indent guides |
| `avante.lua` | AI code editing (Claude, Gemini) |
| `codecompanion.lua` | AI chat interface via Codebuddy CLI |

### Language Extras (`lua/plugins/extras/lang/`)

- `go.lua` - Go-specific LSP/tool overrides

LazyVim extras enabled via `lazyvim.json`: Docker, Go, Python, Rust, TypeScript, Vue, JSON, YAML, TOML, SQL, Markdown.

### Other Directories

- **`after/ftplugin/`** - Per-filetype overrides (go, gitrebase, help, man, markdown, qf, tmux)
- **`snippets/`** - UltiSnips-format snippets for C, Proto, Python, SQL

## Code Style

- **Lua:** 2-space indent (per `.editorconfig`)
- **JS/Python/CSS:** 4-space indent
- **Makefiles:** tabs
- **Line length:** 120 chars
- **Formatter:** stylua (indicated by `-- stylua: ignore` comments)
- UTF-8, LF line endings, final newline, trim trailing whitespace

## Key Patterns

- Plugin configs follow LazyVim's override pattern: return a table of spec entries where each entry targets a plugin by name and provides `opts`, `keys`, or `config` overrides.
- Comments reference the upstream LazyVim file being extended (e.g., `-- NOTE: This extends $XDG_DATA_HOME/nvim/lazy/LazyVim/lua/lazyvim/plugins/...`).
- XDG directory conventions are used throughout (`XDG_CONFIG_HOME`, `XDG_DATA_HOME`, `XDG_CACHE_HOME`).
