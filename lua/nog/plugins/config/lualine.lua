local utils = require("nog.utils")
local lualineLogger = utils.moduleLogger("lualine")

local function catpuccin_colors()
  local latte = require("catppuccin.palettes").get_palette("latte");

  local custom_catppuccin = {}

  custom_catppuccin.normal = {
    a = { bg = "#989aea", fg = latte.base, gui = "bold" },
    b = { bg = latte.mantle, fg = "#989aea" },
    c = { bg = latte.base, fg = latte.crust }
  }

  custom_catppuccin.insert = {
    a = { bg = latte.green, fg = latte.base, gui = "bold" },
    b = { bg = latte.surface1, fg = latte.teal },
  }

  custom_catppuccin.command = {
    a = { bg = latte.peach, fg = latte.base, gui = "bold" },
    b = { bg = latte.surface1, fg = latte.peach },
  }

  custom_catppuccin.visual = {
    a = { bg = latte.mauve, fg = latte.base, gui = "bold" },
    b = { bg = latte.surface1, fg = latte.mauve },
  }

  custom_catppuccin.replace = {
    a = { bg = latte.red, fg = latte.base, gui = "bold" },
    b = { bg = latte.surface1, fg = latte.red },
  }

  custom_catppuccin.inactive = {
    a = { bg = latte.mantle, fg = latte.blue },
    b = { bg = latte.mantle, fg = latte.surface1, gui = "bold" },
    c = { bg = latte.mantle, fg = latte.overlay0 },
  }

  return custom_catppuccin
end

--local gruvcolors = require("gruvbox-baby.colors").config()
--local function gruvbox_colors()
  --  local custom_gruvbox = require("lualine.themes.gruvbox-baby")
  --
  --  custom_gruvbox.normal.b.bg = gruvcolors.dark
  --  custom_gruvbox.normal.c.bg = gruvcolors.dark
  --
  --  custom_gruvbox.insert.b.bg = gruvcolors.dark
  --  custom_gruvbox.insert.c.bg = gruvcolors.dark
  --
  --  custom_gruvbox.visual.b.bg = gruvcolors.dark
  --  custom_gruvbox.visual.c.bg = gruvcolors.dark
  --
  --  custom_gruvbox.replace.b.bg = gruvcolors.dark
  --  custom_gruvbox.replace.c.bg = gruvcolors.dark
  --
  --  custom_gruvbox.command.b.bg = gruvcolors.dark
  --  custom_gruvbox.command.c.bg = gruvcolors.dark
  --
  --  custom_gruvbox.inactive.b.bg = gruvcolors.dark
  --  custom_gruvbox.inactive.c.bg = gruvcolors.dark
  --
  --  return custom_gruvbox
  --end
  --
  --local onedarkpallete = require("onedark.palette")
  --local function onelight_colors()
    --  local custom_onelight = require("lualine.themes.onelight")
    --  custom_onelight.normal.c.fg = '#c0c0c0'
    --
    --  return custom_onelight
    --end

    local function get_cwd()
      local shouldLog = false
      local log = utils.getFuncLogger(lualineLogger, "get_cwd", shouldLog)

      local cwd = utils.getCwdShort()
      local fileCwd = utils.getFileCwdShort()

      log("cwd: " .. cwd .. " | fileCwd: " .. fileCwd)

      if utils.match(fileCwd, cwd) then
        fileCwd = utils.replace(fileCwd, cwd, ">>")
      end

      log("cwd2: " .. cwd .. " | fileCwd2: " .. fileCwd)

      -- user in cwd?
      if fileCwd == ">>" then
        return '家 ' .. cwd
      else -- user in folder inside cwd OR outside cwd
        return '家 ' .. cwd .. ' 宿 ' .. fileCwd
      end
    end

    local M = {}

    function M.setup()
      --  local custom_gruvbox = gruvbox_colors()
      --  local custom_onelight = onelight_colors()

      require("lualine").setup {
        options = {
          theme = catpuccin_colors(),
          component_separators = { "│", "│" },
          section_separators = { "", "" },
          globalstatus = true,
        },
        sections = {
          lualine_a = {
            "mode",
          },
          lualine_b = { { "filename", path = 0} },
          lualine_c = {
            { get_cwd },
          },
          lualine_x = {
            "encoding",
            "filetype",
          },
          lualine_y = { "branch" },
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
