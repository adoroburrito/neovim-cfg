local M = {}

function M.setup()
  require("nvim-tree").setup {
    disable_netrw = true,
    hijack_netrw = true,
    view = {
      number = false,
      relativenumber = false,
    },
    filters = {
      custom = { ".git" },
    },
    renderer = {
      indent_markers = {
        enable = true,
        inline_arrows = true,
        icons = {
          corner = "└",
          edge = "│",
          item = "│",
          none = " ",
        },
      },
      icons = {
        webdev_colors = true,
        padding = " ",
        symlink_arrow = " -> ",
        glyphs = {
          default = "•",
          symlink = "S",
          bookmark = "B",
          folder = {
            arrow_closed = "▶",
            arrow_open = "●",
            default = "✚",
            open = "✚",
            empty = "$",
            empty_open = "$●",
            symlink = "S",
            symlink_open = "S●",
          },
          git = {
            unstaged = "✗",
            staged = "✓",
            unmerged = "?",
            renamed = "➜",
            untracked = "★",
            deleted = "D",
            ignored = "◌",
          },
        },
      }
    },
    diagnostics = {
      enable = false
    }
  }
end

return M
