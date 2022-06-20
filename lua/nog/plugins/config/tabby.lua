local M = {}

function M.setup()
  local tabby = require "tabby"

  tabby.setup({
    tabline = require("tabby.presets").tab_only
  })

end

return M
