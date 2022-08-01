local M = {}

local gruvcolors = require("gruvbox-baby.colors").config()
function gruvbox_colors()
  local custom_gruvbox = require("lualine.themes.gruvbox-baby")

  custom_gruvbox.normal.b.bg = gruvcolors.dark
  custom_gruvbox.normal.c.bg = gruvcolors.dark

  custom_gruvbox.insert.b.bg = gruvcolors.dark
  custom_gruvbox.insert.c.bg = gruvcolors.dark

  custom_gruvbox.visual.b.bg = gruvcolors.dark
  custom_gruvbox.visual.c.bg = gruvcolors.dark

  custom_gruvbox.replace.b.bg = gruvcolors.dark
  custom_gruvbox.replace.c.bg = gruvcolors.dark

  custom_gruvbox.command.b.bg = gruvcolors.dark
  custom_gruvbox.command.c.bg = gruvcolors.dark

  custom_gruvbox.inactive.b.bg = gruvcolors.dark
  custom_gruvbox.inactive.c.bg = gruvcolors.dark

  return custom_gruvbox
end

local onedarkpallete = require("onedark.palette")
function onelight_colors()
  local custom_onelight = require("lualine.themes.onelight")

  return custom_onelight
end

function M.setup()
  local custom_gruvbox = gruvbox_colors()
  local custom_onelight = onelight_colors()

  require("lualine").setup {
    options = {
      theme = custom_onelight,
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
          --color_error = gruvcolors.error_red,
          --color_warn = gruvcolors.bright_yellow,
          --color_info = gruvcolors.milk,
          --color_hint = gruvcolors.milk,
          color_error = onedarkpallete.light.red,
          color_warn = onedarkpallete.light.yellow,
          color_info = onedarkpallete.light.bg0,
          color_hint = onedarkpallete.light.bg0,
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
