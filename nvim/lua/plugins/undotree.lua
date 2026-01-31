return {
  {
    "mbbill/undotree",
    cmd = "UndotreeToggle", -- Lazy load when :UndotreeToggle is used
    keys = {
      { "<leader>u", "<cmd>UndotreeToggle<CR>", desc = "Toggle UndoTree" },
    },
    config = function()
      vim.g.undotree_WindowLayout = 2 -- Vertical split layout
      vim.g.undotree_SetFocusWhenToggle = 1 -- Auto-focus the undotree window
      vim.opt.undofile = true -- Enable persistent undo
      vim.opt.undodir = vim.fn.stdpath("data") .. "/undo" -- Store undo history
    end,
  }
}

