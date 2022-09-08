local utils = require("nog.utils")
local lualineLogger = utils.moduleLogger("lualine")

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
      theme = "catppuccin",
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
