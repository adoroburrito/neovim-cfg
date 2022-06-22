local M = {}

function M.setup()
  local tabby = require "tabby"
  local util = require('tabby.util')
  local colors = require('gruvbox-baby.colors').config()

  local hl_tabline = util.extract_nvim_hl('TabLine')
  local hl_tabline_sel = util.extract_nvim_hl('TabLineSel')
  local hl_tabline_fill = util.extract_nvim_hl('TabLineFill')

  local function tab_label(tabid, active)
    local icon_left = active and '' or ''
    local icon_right = active and '' or ''
    local name = util.get_tab_name(tabid)
    return string.format(' %s %s %s ', icon_left, name, icon_right)
  end

  tabby.setup({
    tabline = {
      hl = 'TabLineFill',
      layout = 'tab_only',
      head = {
        { '  ', hl = { fg = colors.light_blue, bg = colors.dark } },
      },
      active_tab = {
        label = function(tabid)
          return {
            tab_label(tabid, true),
            hl = { fg = colors.dark, bg = colors.light_blue, style = 'bold' },
          }
        end,
        left_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
        right_sep = { '', hl = { fg = hl_tabline_sel.bg, bg = hl_tabline_fill.bg } },
      },
      inactive_tab = {
        label = function(tabid)
          return {
            tab_label(tabid, false),
            hl = { fg = colors.bg_light, bg = colors.dark, style = nil },
          }
        end,
        left_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
        right_sep = { '', hl = { fg = hl_tabline.bg, bg = hl_tabline_fill.bg } },
      },
    },
  })

end

return M
