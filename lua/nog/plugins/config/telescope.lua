local M = {}

function M.setup()
  local telescope = require "telescope"
  telescope.load_extension('aerial')

  telescope.setup({
    extensions = {
      aerial = {
        show_nesting = true
      }
    }
  })

end

return M
