local M = {}

function M.setup()
  local indentblankline = require("indent_blankline")

	indentblankline.setup {
    -- for example, context is off by default, use this to turn it on
    space_char_blankline = " ",
    show_current_context = true,
    show_end_of_line = true,
    show_current_context_start = true,
	}
end

return M
