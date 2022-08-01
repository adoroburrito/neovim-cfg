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
		["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },

    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
    },

    c = {
      name = "Config",
      r = { "<Cmd>source $MYVIMRC<Cr>", "Re-source $MYVIMRC" },
    },

    f = {
      name = "Find (telescope)",
      f = { "<cmd>Telescope git_files<cr>", "Files in CWD" },
      F = { "<cmd>Telescope find_files<cr>", "All Files in CWD" },
      g = { "<cmd>Telescope live_grep<cr>", "Grep file contents in CWD" },
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      c = { "<cmd>Telescope commands<cr>", "Commands" },
      m = { "<cmd>Telescope man_pages<cr>", "Man pages" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "(LSP) Document symbols" },
      g = { "<cmd>Telescope lsp_document_symbols<cr>", "(GIT) Status" },
    },

    F = {
      name = "(cd to) Useful folders",
      c = { "<cmd>cd ~/.config/nvim<cr><cmd>NvimTreeOpen ~/.config/nvim<cr>", "Config folder" },
      p = { "<cmd>cd ~/fun<cr><cmd>NvimTreeOpen ~/fun<cr>", "Project folder" },
      d = { "<cmd>cd ~/Downloads<cr><cmd>NvimTreeOpen ~/Downloads/<cr>", "Downloads folder" },
      h = { "<cmd>cd ~/<cr><cmd>NvimTreeOpen ~/<cr>", "Home folder" },
      w = { "<cmd>cd ~/work<cr><cmd>NvimTreeOpen ~/work<cr>", "Work folder" },
    },

    q = {
      name = "Quick edit",
      c = { "<cmd>e ~/.config/nvim/lua/nog/plugins/init.lua<cr>", "Plugins config" },
      w = { "<cmd>e ~/.config/nvim/lua/nog/plugins/config/whichkey.lua<cr>", "Whichkey config" },
    },

    z = {
      name = "Packer",
      c = { "<cmd>PackerCompile<cr>", "Compile" },
      i = { "<cmd>PackerInstall<cr>", "Install" },
      s = { "<cmd>PackerSync<cr>", "Sync" },
      S = { "<cmd>PackerStatus<cr>", "Status" },
      u = { "<cmd>PackerUpdate<cr>", "Update" },
      p = { "<cmd>PackerProfile<cr>", "Profile" },
    },

    n = {
      name = "Nog utils",
      t = { "<cmd>e ~/temp.md<cr>", "Temp (~/temp.md)" },
      g = { "<cmd>cd %:h | cd `git rev-parse --show-toplevel`<cr><cmd>execute 'NvimTreeOpen' getcwd()<cr>", "Set CWD as this file's git root" },
      r = { "<cmd>luafile ~/.config/nvim/init.lua<cr>", "Reload cfg" },
      n = { "<cmd>require('notify')('Notify!')<cr>", "Notify test" },
    },

  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
