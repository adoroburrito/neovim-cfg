local M = {}

function M.setup()
  local tabby = require "tabby"
  local util = require('tabby.util')
--  local gruvcolors = require('gruvbox-baby.colors').config()
--  local onedarkpallete = require("onedark.palette")
  local latte = require("catppuccin.palettes").get_palette("latte")
  local targetcolors = {
--    gruvbox = {
--      highlight = gruvcolors.light_blue,
--      lowlight = gruvcolors.dark,
--      bright = gruvcolors.bg_light,
--    },
--    onelight = {
--      highlight = onedarkpallete.light.bg_blue,
--      lowlight = onedarkpallete.light.bg_d,
--      bright = onedarkpallete.light.bg0,
--    },
      catppuccin = {
        highlight = "#989aea",
        lowlight = latte.base,
        bright = latte.base,
      }
  }

  local hl_tabline = util.extract_nvim_hl('TabLine')
  local hl_tabline_sel = util.extract_nvim_hl('TabLineSel')
  local hl_tabline_fill = util.extract_nvim_hl('TabLineFill')

  local function tab_label(tabid, active)
    local icon_left = active and '>' or ''
    local icon_right = active and '<' or ''
    local name = util.get_tab_name(tabid)
    return string.format(' %s %s %s ', icon_left, name, icon_right)
  end

  tabby.setup({
    tabline = {
      hl = 'TabLineFill',
      layout = 'tab_only',
      head = {
        { ' 心 ', hl = { fg = targetcolors.catppuccin.highlight, bg = targetcolors.catppuccin.lowlight } },
      },
      active_tab = {
        label = function(tabid)
          return {
            tab_label(tabid, true),
            hl = { fg = targetcolors.catppuccin.bright, bg = targetcolors.catppuccin.highlight, style = 'bold' },
          }
        end,
        left_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
        right_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
      },
      inactive_tab = {
        label = function(tabid)
          return {
            tab_label(tabid, false),
            hl = { fg = targetcolors.catppuccin.lowlight, bg = targetcolors.catppuccin.bright, style = nil },
          }
        end,
        left_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
      },
    },
  })

end

return M
