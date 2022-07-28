local M = {}

function M.setup()

  local colors = require("gruvbox-baby.colors").config()
  local custom_gruvbox = require("lualine.themes.gruvbox-baby")

  custom_gruvbox.normal.b.bg = colors.dark
  custom_gruvbox.normal.c.bg = colors.dark

  custom_gruvbox.insert.b.bg = colors.dark
  custom_gruvbox.insert.c.bg = colors.dark

  custom_gruvbox.visual.b.bg = colors.dark
  custom_gruvbox.visual.c.bg = colors.dark

  custom_gruvbox.replace.b.bg = colors.dark
  custom_gruvbox.replace.c.bg = colors.dark

  custom_gruvbox.command.b.bg = colors.dark
  custom_gruvbox.command.c.bg = colors.dark

  custom_gruvbox.inactive.b.bg = colors.dark
  custom_gruvbox.inactive.c.bg = colors.dark

  require("lualine").setup {
    options = {
      theme = custom_gruvbox,
      component_separators = { "│", "│" },
      section_separators = { "", "" },
      globalstatus = true,
    },
    sections = {
      lualine_a = {
        "mode",
      },
      lualine_b = { { "filename", path = 2} },
      lualine_c = {
        {
          "lsp_progress",
          "diagnostics",
          sources = { "nvim_diagnostic" },
          sections = { "error", "warn", "info", "hint" },
          color_error = colors.error_red,
          color_warn = colors.bright_yellow,
          color_info = colors.milk,
          color_hint = colors.milk,
          symbols = { error = "▪", warn = "▴", info = "›", hint = "▸" },
        },
      },
      lualine_x = {
        "branch",
        "encoding",
        "fileformat",
        "filetype",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { "filename" },
      lualine_x = { "filetype" },
      lualine_y = {},
      lualine_z = {},
    },
    tabline = {},
    extensions = { "nvim-tree", "fugitive" },
  }
end

return M
