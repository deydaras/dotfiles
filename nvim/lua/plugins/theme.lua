return {
  -- install the catppuccin theme
  {
    "catppuccin/nvim",
    name = "catppuccin",
    priority = 1000,
    opts = {
      term_colors = true,
      styles = {
        comments = { "italic" },
        functions = { "bold" }, -- Make functions bold
        keywords = { "italic" },
        variables = {},
      },
    },
  },

  -- Configure LazyVim to load this colorscheme
  {
    "LazyVim/LazyVim",
    opts = {
      colorscheme = "catppuccin",
    },
  },
}
