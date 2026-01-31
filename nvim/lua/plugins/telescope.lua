return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }, -- Required dependency
    cmd = "Telescope", -- Load Telescope only when needed
    keys = {
      { "<leader>cc", function() require("telescope.builtin").find_files() end, desc = "Find Files" },
      { "<leader>cl", function() require("telescope.builtin").live_grep() end, desc = "Live Grep" },
      { "<leader>cm", function() require("telescope.builtin").buffers() end, desc = "Buffers" },
      { "<leader>ch", function() require("telescope.builtin").help_tags() end, desc = "Help Tags" },
    },
    config = function()
      require("telescope").setup({
        defaults = {
          layout_strategy = "horizontal",
          sorting_strategy = "ascending",
          mappings = {
            i = {
              ["<C-j>"] = "move_selection_next",
              ["<C-k>"] = "move_selection_previous",
              ["<C-q>"] = "send_selected_to_qflist",
            },
          },
        },
      })
    end,
  }
}

