return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" }, -- Only load when opening a file
  config = function()
    require("conform").setup({
      formatters_by_ft = {
        -- DevOps & Config
        terraform = { "terraform_fmt" },
        hcl = { "terraform_fmt" },
        yaml = { "prettier" },
        dockerfile = { "hadolint" },
        sh = { "shfmt" },
        yml = { "prettier" },
        -- Data & Backend
        python = { "ruff_format", "black", stop_after_first = true },
        sql = { "sqlfmt" },
        go = { "goimports", "gofmt", stop_after_first = true },
        rust = { "rustfmt" },

        -- Web & Frontend
        javascript = { "prettier" },
        typescript = { "prettier" },
        json = { "prettier" },
        markdown = { "prettier" },

        -- Neovim Config
        lua = { "stylua" },
      },
    })

    -- Add your Alt-g keybinding here so it's only active when the plugin is loaded
    vim.keymap.set("n", "<M-g>", function()
      require("conform").format({ async = true, lsp_fallback = true })
    end, { desc = "Format code with Alt-g" })
  end,
}

