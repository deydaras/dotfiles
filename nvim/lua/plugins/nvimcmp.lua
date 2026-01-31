-- ~/.config/nvim/lua/plugins/nvimcmp.lua
return {
  "hrsh7th/nvim-cmp",                     -- completion plugin
  version = false,                        -- use HEAD
  event = "InsertEnter",                  -- load on Insert mode
  dependencies = {                        -- completion sources
    "hrsh7th/cmp-nvim-lsp",
    "hrsh7th/cmp-buffer",
    "hrsh7th/cmp-path",
  },
  opts = function()
    -- highlight for ghost text
    vim.api.nvim_set_hl(0, "CmpGhostText", { link = "Comment", default = true })

    local cmp      = require("cmp")                  -- import nvim-cmp
    local defaults = require("cmp.config.default")() -- default settings
    local auto_sel = true                            -- enable auto-selection

    return {
      -- completion menu behavior
      completion = {
        completeopt = "menu,menuone,noinsert" .. (auto_sel and "" or ",noselect"),
      },
      preselect = auto_sel and cmp.PreselectMode.Item or cmp.PreselectMode.None,

      -- key mappings
      mapping = cmp.mapping.preset.insert({
        ["<C-b>"] = cmp.mapping.scroll_docs(-4),       -- scroll docs up
        ["<C-f>"] = cmp.mapping.scroll_docs(4),        -- scroll docs down
        ["<C-n>"] = cmp.mapping.select_next_item(),    -- next item
        ["<C-p>"] = cmp.mapping.select_prev_item(),    -- prev item
        ["<C-Space>"] = cmp.mapping.complete(),        -- trigger completion
        ["<CR>"] = cmp.mapping.confirm({ select = auto_sel }),    -- confirm
        ["<S-CR>"] = cmp.mapping.confirm({ behavior = cmp.ConfirmBehavior.Replace }), 
        ["<C-CR>"] = function(fallback)                -- abort + fallback
        cmp.abort() 
        fallback()
        end,
        -- example: Tab to next snippet or completion
        ["<Tab>"] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { "i", "s" }),
      }),

      -- sources
      sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "path" },
      }, {
        { name = "buffer" },
      }),

      -- formatting (icons, truncation)
      formatting = {
        format = function(entry, item)
          -- example: add a kind icon (you can customize)
          local kind_icons = { Function = "ƒ", Variable = "𝑥"}
          if kind_icons[item.kind] then
            item.kind = kind_icons[item.kind] .. item.kind
          end
          return item
        end,
      },

      -- experimental ghost text
      experimental = {
        ghost_text = { hl_group = "CmpGhostText" },
      },

      sorting = defaults.sorting,
    }
  end,
}
