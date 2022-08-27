local notify = require("notify")
notify.setup({
  background_colour = "#000000",
  render = "minimal",
  stages = "slide",
  fps = 60
})

local M = {}

function M.base(msg, name, level)
  local prefix = name and name .. ": " or ""
  notify(prefix .. msg, level, { title = name })
end

function M.warn(msg, name)
  M.base(msg, name, "warn")
end

function M.error(msg, name)
  M.base(msg, name, "error")
end

function M.info(msg, name)
  M.base(msg, name, "info")
end

return M
