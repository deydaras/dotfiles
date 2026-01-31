
--  Try it with `yap` in normal mode
--  See `:help vim.highlight.on_yank()`
vim.api.nvim_create_autocmd("TextYankPost", {
  desc = "Highlight when yanking (copying) text",
  group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

vim.api.nvim_create_autocmd("TermOpen", {
  group = vim.api.nvim_create_augroup("custom-term-open", { clear = true }),
  callback = function()
    vim.opt.number = false
    vim.opt.relativenumber = false
  end,
})

local job_id = 0
vim.keymap.set("n", "<space>tt", function()
  vim.cmd.vnew()
  vim.cmd.term()
  vim.cmd.wincmd("J")
  vim.api.nvim_win_set_height(0, 5)

  job_id = vim.bo.channel
end)

local current_command = ""
vim.keymap.set("n", "<space>tl", function()
  current_command = vim.fn.input("Command: ")
end)

-- vim.keymap.set("n", "<space>tm", function()
--   if current_command == "" then
--     current_command = vim.fn.input("Command: ")
--   end
--
--   vim.fn.chansend(job_id, { current_command .. "\r\n" })
-- end)
--
vim.o.autoread = true
vim.api.nvim_create_autocmd({ "BufEnter", "CursorHold", "CursorHoldI", "FocusGained" }, {
  command = "if mode() != 'c' | checktime | endif",
  pattern = { "*" },
})
vim.o.number = true -- Except for current line
vim.o.relativenumber = true -- Relative line numbers
vim.o.breakindent = true -- Preserve indent when wrapping
vim.opt.completeopt = { "menu", "menuone", "noselect" }
vim.o.expandtab = true -- Turn tabs into spaces
vim.o.formatoptions = "rqnlj"
vim.o.gdefault = true -- Use 'g' flag by default with :s/foo/bar
vim.o.exrc = true -- Load .nvim.lua files
vim.o.guifont = "UbuntuMono Nerd Font:h10"
vim.o.ignorecase = true
vim.o.jumpoptions = "stack"
vim.o.laststatus = 3 -- Global statusline
vim.o.mouse = "a" -- Enable use of mouse
vim.o.path = "**" -- Use a recursive path (for :find)
vim.o.previewheight = 5
vim.o.pumblend = 10 -- Transparency for popup-menu
vim.o.ruler = true -- Show the row, column of the cursor
vim.o.shiftwidth = 2
vim.opt.shortmess:append("c") -- for nvim-cmp
vim.opt.shortmess:append("I") -- Hide the startup screen
vim.opt.shortmess:append("A") -- Ignore swap file messages
vim.opt.shortmess:append("a") -- Shorter message formats
vim.o.showmatch = true -- When a bracket is inserted, briefly jump to the matching one
vim.o.showtabline = 2 -- Always show tab line
vim.o.smartcase = true
vim.o.softtabstop = 2
vim.o.splitbelow = true
vim.o.splitright = true
vim.o.switchbuf = "uselast"
vim.o.synmaxcol = 300 -- Don't syntax highlight long lines
vim.o.tabstop = 2
vim.o.textwidth = 100 -- Line width of 100
vim.o.updatetime = 400 -- CursorHold time default is 4s. Way too long
vim.o.whichwrap = "h,l" -- allow cursor to wrap to next/prev line
vim.o.wrap = true
vim.o.linebreak = true
vim.opt.wildignore:append(
  "*.png,*.jpg,*.jpeg,*.gif,*.wav,*.aiff,*.dll,*.pdb,*.mdb,*.so,*.swp,*.zip,*.gz,*.bz2,*.meta,*.svg,*.cache,*/.git/*"
)
vim.o.wildmenu = true
vim.o.wildmode = "longest,list,full"

vim.keymap.set("n", "j", [[(v:count > 5 ? "m'" . v:count . 'j' : 'gj')]], { expr = true })
vim.keymap.set("n", "k", [[(v:count > 5 ? "m'" . v:count . 'k' : 'gk')]], { expr = true })

