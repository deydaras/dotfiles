
local map = vim.keymap.set

map("n", "<leader>w", "<cmd>q<cr>", { desc = "Quit All" })
map("n", "<leader>x", "<cmd>qa!<cr>", { desc = "Quit All" })
map("n", "<leader>l", "<cmd>Ex<cr>", { desc = "Return to dir" })
map({ "i", "n" }, "<esc>", "<cmd>noh<cr><esc>", { desc = "Escape and clear hlsearch" })

map({ "i", "v", "n", "s" }, "<A-s>", "<cmd>w<cr><esc>", { desc = "Save file" })
map("n", "<C-h>", "<C-w>h")
map("n", "<C-j>", "<C-w>j")
map("n", "<C-k>", "<C-w>k")
map("n", "<C-e>", "<C-w>l")

-- terminal
map("t", "<C-h>", "<cmd>wincmd h<CR>")
map("t", "<C-j>", "<cmd>wincmd j<CR>")
map("t", "<C-k>", "<cmd>wincmd k<CR>")
map("t", "<C-e>", "<cmd>wincmd l<CR>")

map("n", "<C-Up>", ":resize -2<CR>")
map("n", "<C-Down>", ":resize +2<CR>")
map("n", "<C-Left>", ":vertical resize -2<CR>")
map("n", "<C-Right>", ":vertical resize +2<CR>")

-- terminal
map("t", "<C-Up>", "<cmd>resize -2<CR>")
map("t", "<C-Down>", "<cmd>resize +2<CR>")
map("t", "<C-Left>", "<cmd>vertical resize -2<CR>")
map("t", "<C-Right>", "<cmd>vertical resize +2<CR>")



-- Normal mode
map("n", "l", "e", { noremap = true })
map("n", "e", "l", { noremap = true })
map("n", "L", "E", { noremap = true })
map("n", "E", "L", { noremap = true })

map("x", "l", "e", { noremap = true })
map("x", "e", "l", { noremap = true })
map("x", "L", "E", { noremap = true })
map("x", "E", "L", { noremap = true })
