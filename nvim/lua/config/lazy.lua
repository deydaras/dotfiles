-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  local lazyrepo = "https://github.com/folke/lazy.nvim.git"
  local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
  if vim.v.shell_error ~= 0 then
    vim.api.nvim_echo({
      { "Failed to clone lazy.nvim:\n", "ErrorMsg" },
      { out,                            "WarningMsg" },
      { "\nPress any key to exit..." },
    }, true, {})
    vim.fn.getchar()
    os.exit(1)
  end
end

vim.opt.runtimepath:prepend(lazypath)

vim.g.mapleader = " "
vim.g.maplocalleader = "\\"

require("lazy").setup({
  spec = {
  { "folke/tokyonight.nvim", config = function() vim.cmd.colorscheme "tokyonight" end },
  { import = "plugins.treesitter" },
  { import = "plugins.telescope" },
  { import = "plugins.harpoon" },
  { import = "plugins.undotree" },
  { import = "plugins.lsp" },
  { import = "plugins.mason" },
  { import = "plugins.obsidian" },
  -- { import = "plugins.blink" },
  { import = "plugins.term"},
  { import = "plugins.fzf"},
  { import = "plugins.autopairs"},
  -- { import = "plugins.avante"},
  { import = "plugins.nvimcmp"},
  -- { import = "plugins.snippets"},

  { import = "plugins.surround"},
  { import = "plugins.autosave"},
  { import = "plugins.gittool"},
  -- { import = "plugins.composer"},

  },
  change_detection = {
    enabled = false,
    notify = false,
  },
})

