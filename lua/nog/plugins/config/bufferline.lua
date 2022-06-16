local M = {}

function M.setup()
  require("bufferline").setup {
    options = {
      mode = "tabs",
      numbers = "none",
      diagnostics = "nvim_lsp",
      separator_style = "thick",
      show_tab_indicators = true,
      show_buffer_close_icons = false,
      show_close_icon = false,
    },
  }
end

return M
