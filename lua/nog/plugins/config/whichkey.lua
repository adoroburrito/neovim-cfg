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
    v = {
      name = "Vimspector",
      G = { "<cmd>lua require('nog.plugins.config.vimspector').generate_debug_profile()<cr>", "Generate Debug Profile" },
      I = { "<cmd>VimspectorInstall<cr>", "Install" },
      U = { "<cmd>VimspectorUpdate<cr>", "Update" },
      R = { "<cmd>call vimspector#RunToCursor()<cr>", "Run to Cursor" },
      c = { "<cmd>call vimspector#Continue()<cr>", "Continue" },
      i = { "<cmd>call vimspector#StepInto()<cr>", "Step Into" },
      o = { "<cmd>call vimspector#StepOver()<cr>", "Step Over" },
      s = { "<cmd>call vimspector#Launch()<cr>", "Start" },
      t = { "<cmd>call vimspector#ToggleBreakpoint()<cr>", "Toggle Breakpoint" },
      u = { "<cmd>call vimspector#StepOut()<cr>", "Step Out" },
      S = { "<cmd>call vimspector#Stop()<cr>", "Stop" },
      r = { "<cmd>call vimspector#Restart()<cr>", "Restart" },
      x = { "<cmd>VimspectorReset<cr>", "Reset" },
      H = { "<cmd>lua require('nog.plugins.config.vimspector').toggle_human_mode()<cr>", "Toggle HUMAN mode" },
    },

  }

  whichkey.setup(conf)
  whichkey.register(mappings, opts)
end

return M
