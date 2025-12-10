# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

This is a Neovim configuration based on LazyVim. The configuration uses lazy.nvim for plugin management and follows LazyVim's conventions for extending the base setup.

## Architecture

**Entry point:** `init.lua` loads `config.lazy`

**Core configuration in `lua/config/`:**
- `lazy.lua` - Plugin manager setup and LazyVim extras imports
- `options.lua` - Vim options (root detection prioritizes `.git`)
- `keymaps.lua` - Custom key mappings
- `autocmds.lua` - Auto commands (includes TypeScript auto-import on save, rust-tools setup)

**Plugins in `lua/plugins/`:** Each file returns a table of plugin specs that extend or override LazyVim defaults.

## Enabled LazyVim Extras

Language support: TypeScript, Go, JSON, Docker, Markdown, Terraform, YAML, Helm, TeX, TOML, Tailwind
Formatting: Prettier, ESLint
Coding: LuaSnip, mini-surround, yanky
Editor: illuminate, refactoring
UI: mini-indentscope, treesitter-context
AI: Copilot

## Key Customizations

- Neo-tree positioned on the right
- Harpoon 2 for file navigation with fzf-lua integration and custom lualine display
- TypeScript: Auto-adds missing imports on save via synchronous LSP code actions
- blink.cmp with super-tab preset and LuaSnip
- Custom snippets loaded from `snippets/` directory
- Buffer navigation via `<leader>1-9` and `<S-left>/<S-right>`
