return {
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup({
      enabled = true, -- start auto-save when the plugin is loaded
      execution_message = {
        message = function() return ("AutoSave: saved at " .. vim.fn.strftime("%H:%M:%S")) end,
        dim = 0.18, -- dim the color of the message
        cleaning_interval = 1250, -- (milliseconds) automatically clean MsgArea after displaying message
      },
      trigger_events = { "InsertLeave", "TextChanged" }, -- vim events that trigger auto-save
      condition = function(buf)
        local fn = vim.fn
        local utils = require("auto-save.utils.data")

        if fn.getbufvar(buf, "&buftype") ~= "" then return false end
        return true
      end,
    })
  end,
}
