local opt = vim.opt

opt. scrolloff = 8
opt.number = true
opt.relativenumber = true
opt.clipboard = "unnamedplus"
opt.undofile = true
vim.opt.expandtab = true   -- Convert tabs to spaces
vim.opt.shiftwidth = 4     -- Size of an indent
vim.opt.tabstop = 4        -- Number of spaces tabs count for
vim.opt.smartindent = true -- Insert indents automatically
-- Define the undo directory as a string
local undodir = vim.fn.expand("~/.local/share/nvim/undo")

-- Ensure Neovim uses this directory for persistent undo
vim.opt.undodir = undodir
vim.opt.undofile = true  -- Enable persistent undo
vim.opt.laststatus = 3

-- Ensure the directory exists
if vim.fn.isdirectory(tostring(undodir)) == 0 then
  vim.fn.mkdir(undodir, "p")
end

