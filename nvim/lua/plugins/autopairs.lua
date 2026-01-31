return {
  -- Disable the default mini.pairs
  { "echasnovski/mini.pairs", enabled = false },

  -- Install nvim-autopairs
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter",
    config = true, -- checks if you have cmp (completion) and sets it up automatically
    opts = {
        check_ts = true, -- enable treesitter
        fast_wrap = {
            map = "<M-l>", -- Alt+e to wrap text after typing
        },
    },
  },
}
