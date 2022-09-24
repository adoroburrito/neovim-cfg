local M = {}

function M.setup()
  local whichkey = require "which-key"

  local conf = {
    window = {
      border = "shadow", -- none, single, double, shadow
      position = "top", -- bottom, top
    },
  }

  local normalOpts = {
    mode = "n", -- Normal mode
    prefix = "<Leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local visualOpts = {
    mode = "v", -- Normal mode
    prefix = "<Leader>",
    buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
    silent = true, -- use `silent` when creating keymaps
    noremap = true, -- use `noremap` when creating keymaps
    nowait = false, -- use `nowait` when creating keymaps
  }

  local normalMappings = {
    ["w"] = { "<cmd>update!<CR>", "Save" },
		["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
		[" "] = { "<cmd>HopWord<cr>", "Explorer" },

    b = {
      name = "Buffer",
      c = { "<Cmd>bd!<Cr>", "Close current buffer" },
      D = { "<Cmd>%bd|e#|bd#<Cr>", "Delete all buffers" },
      s = { "<Cmd>SymbolsOutline<cr>", "Toggle Show Symbols"}
    },
    
    r = {
      name = "Random",
      m = { "<Cmd>MarkdownPreviewToggle<Cr>", "Markdown Preview" }
    },

    c = {
      name = "Config",
      r = { "<Cmd>source $MYVIMRC<Cr>", "Re-source $MYVIMRC" },
    },

    t = {
      name = "Terminal",
      t = { "<Cmd>ToggleTerm<Cr>", "Toggle terminal" },
      n = { '<Cmd>TermExec cmd="node"<Cr>', "Open nodejs repl" },
    },

    f = {
      name = "Find (telescope)",
      a = { "<cmd>Telescope aerial<cr>", "Symbols (Aerial)" },
      f = { "<cmd>Telescope git_files<cr>", "Files in CWD" },
      F = { "<cmd>Telescope find_files<cr>", "All Files in CWD" },
      g = { "<cmd>Telescope live_grep<cr>", "Grep file contents in CWD" },
      b = { "<cmd>Telescope buffers<cr>", "Buffers" },
      c = { "<cmd>Telescope commands<cr>", "Commands" },
      m = { "<cmd>Telescope man_pages<cr>", "Man pages" },
      s = { "<cmd>Telescope lsp_document_symbols<cr>", "(LSP) Document symbols" },
    },

    F = {
      name = "(cd to) Useful folders",
      c = { "<cmd>cd ~/.config/nvim<cr><cmd>NvimTreeOpen ~/.config/nvim<cr>", "Config folder" },
      p = { "<cmd>cd ~/fun<cr><cmd>NvimTreeOpen ~/fun<cr>", "Project folder" },
      d = { "<cmd>cd ~/Downloads<cr><cmd>NvimTreeOpen ~/Downloads/<cr>", "Downloads folder" },
      h = { "<cmd>cd ~/<cr><cmd>NvimTreeOpen ~/<cr>", "Home folder" },
      w = { "<cmd>cd ~/work<cr><cmd>NvimTreeOpen ~/work<cr>", "Work folder" },
      n = { "<cmd>cd ~/notes<cr><cmd>NvimTreeOpen ~/notes<cr>", "Notes folder" },
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
      b = { "<cmd>!git blame % > ~/temp-dg.md<cr><cmd>tabnew ~/temp-dg.md<cr>", "Git blame for this file" },
      r = { "<cmd>luafile ~/.config/nvim/init.lua<cr>", "Reload cfg" },
      n = { "<cmd>require('notify')('Notify!')<cr>", "Notify test" },
    },

    m = {
      name = "Nog modules",
      n = { "<cmd>lua require('nog.modules.notes').open_note()<cr>", "Open today's note" },
      N = { "<cmd>lua require('nog.modules.notes').find_notes()<cr>", "Find notes" },
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

  local visualMappings = {
    r = {
      name = "Refactor",
      f = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Function')<CR>", "Extract Function" },
      F = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Function To File')<CR>", "Extract Function to File" },
      v = { "<Esc><Cmd>lua require('refactoring').refactor('Extract Variable')<CR>", "Extract Variable" },
      V = { "<Esc><Cmd>lua require('refactoring').refactor('Inline Variable')<CR>", "Inline Variable" },
      b = { "<Cmd>lua require('refactoring').refactor('Extract Block')<CR>", "Extract Block" },
      B = { "<Cmd>lua require('refactoring').refactor('Extract Block To File')<CR>", "Extract Block To File" },
    },
  }

  whichkey.setup(conf)
  whichkey.register(normalMappings, normalOpts)
  whichkey.register(visualMappings, visualOpts)
end

return M
