local M = {}

function M.setup()
  local status_ok, indentblankline = pcall(require, "indent_blankline")
  if not status_ok then
    return
  end

	indentblankline.setup {
    -- for example, context is off by default, use this to turn it on
    space_char_blankline = " ",
    show_current_context = true,
    show_current_context_start = true,
	}
end

return M
