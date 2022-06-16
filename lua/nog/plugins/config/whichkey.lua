local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = "single", -- none, single, double, shadow
      position = "bottom", -- bottom, top
    },
  }

  local opts = {
    mode = "n", -- Normal mode
    prefix = "<Leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local mappings = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
    ["q"] = { "<cmd>q!<CR>", "Quit" },

    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

    c = {
      name = "Config",
      r = { "<Cmd>source $MYVIMRC<Cr>", "Re-source $MYVIMRC" },
    },

    z = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
    },

		f = {
			name = "Find",
      f = {
        name = "Files",
        p = { "<cmd>FzfLua files<cr>", "In current path" },
        h = { "<cmd>FzfLua oldfiles<cr>", "Opened files history" },
        g = { "<cmd>FzfLua live_grep<cr>", "Live grep" },
      },
			b = {
        name = "Buffers",
        c = { "<cmd>FzfLua lgrep_curbuf<cr>", "In current buffer" },
        n = { "<cmd>FzfLua buffers<cr>", "Buffer names" },
      },
			c = { "<cmd>FzfLua commands<cr>", "Commands" },
			e = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
			h = { "<cmd>HopWord<cr>", "Hop" },
		},
  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
