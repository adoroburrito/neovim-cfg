local M = {}

function M.setup()
  -- Indicate first time installation
  local packer_bootstrap = false

  -- packer.nvim configuration
  local conf = {
    profile = {
      enable = true,
      threshold = 0, -- the amount in ms that a plugins load time must be over for it to be included in the profile
    },
    display = {
      open_fn = function()
        return require("packer.util").float { border = "rounded" }
      end,
    },
  }

  -- Check if packer.nvim is installed
  -- Run PackerCompile if there are changes in this file
  local function packer_init()
    local fn = vim.fn
    local install_path = fn.stdpath "data" .. "/site/pack/packer/start/packer.nvim"
    if fn.empty(fn.glob(install_path)) > 0 then
      packer_bootstrap = fn.system {
        "git",
        "clone",
        "--depth",
        "1",
        "https://github.com/wbthomason/packer.nvim",
        install_path,
      }
      vim.cmd [[packadd packer.nvim]]
    end
    vim.cmd "autocmd BufWritePost plugins.lua source <afile> | PackerCompile"
  end

  -- Plugins
  local function plugins(use)
    use { "wbthomason/packer.nvim" }

    --
    -- BEGIN!
    --

    -- Colorscheme
    use {
      "luisiacc/gruvbox-baby",
      config = function()
        vim.cmd "syntax on"
        vim.g.gruvbox_baby_function_style = "italic"
        vim.g.gruvbox_baby_keyword_style = "bold"
        -- vim.cmd[[colorscheme gruvbox-baby]]
      end,
    }

    use {
      "navarasu/onedark.nvim",
      config = function()
        vim.o.background='light'
        require('onedark').setup {
          style = 'light',
          code_style = {
            comments = 'italic',
            keywords = 'bold',
            functions = 'none',
            strings = 'italic',
            variables = 'none'
          },
        }
        require('onedark').load()
      end,
    }
    
    use {
      "ayu-theme/ayu-vim",
      config = function()
        vim.cmd[[set termguicolors]]
        vim.cmd[[let ayucolor="light"]]
        -- vim.cmd[[colorscheme ayu]]
      end,
    }

    -- Which key
    use {
      "folke/which-key.nvim",
      config = function()
        require("nog.plugins.config.whichkey").setup()
      end,
    }

    -- StatusLine
    use {
      "nvim-lualine/lualine.nvim",
      event = "VimEnter",
      config = function()
        require("nog.plugins.config.lualine").setup()
      end
    }

    -- IndentLine
    use {
      "lukas-reineke/indent-blankline.nvim",
      event = "BufReadPre",
      config = function()
        require("nog.plugins.config.indentblankline").setup()
      end,
    }

    -- File Explorer
    use {
      "kyazdani42/nvim-tree.lua",
      cmd = { "NvimTreeToggle", "NvimTreeClose" },
      config = function()
        require("nog.plugins.config.nvimtree").setup()
      end,
    }

    -- Tabline
    use {
      "nanozuki/tabby.nvim",
      config = function() 
        require("nog.plugins.config.tabby").setup() 
      end,
    }

    -- Treesitter
    use {
      "nvim-treesitter/nvim-treesitter",
      run = ":TSUpdate",
      config = function()
        require("nog.plugins.config.treesitter").setup()
      end
    }

    -- Telescope
    use {
      'nvim-telescope/telescope.nvim',
      requires = { {'nvim-lua/plenary.nvim'} },
      config = function()
        require("nog.plugins.config.telescope").setup()
      end
    }

    -- Notify
    use "rcarriga/nvim-notify"

    -- LSP configs
    use "hrsh7th/cmp-buffer"
    use "hrsh7th/cmp-path"
    use "hrsh7th/cmp-nvim-lua"
    use "ray-x/cmp-treesitter"
    use "hrsh7th/cmp-cmdline"
    use "saadparwaiz1/cmp_luasnip"
    use "hrsh7th/cmp-nvim-lsp"
    use "williamboman/nvim-lsp-installer"
    use "ray-x/lsp_signature.nvim"
    use "rafamadriz/friendly-snippets"
    use {
      "L3MON4D3/LuaSnip",
      config = function()
        require("nog.plugins.config.luasnip").setup()
      end,
    }

    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      config = function()
        require("nog.plugins.config.lsp").setup()
      end,
    }

    use {
      "hrsh7th/nvim-cmp",
      config = function()
        require("nog.plugins.config.cmp").setup()
      end,
    }

    -- vimspector
    use {
      "puremourning/vimspector",
      config = function()
        require("nog.plugins.config.vimspector").setup()
      end,
    }

    -- refactoring coconut oil
    use {
      "ThePrimeagen/refactoring.nvim",
      requires = {
        {"nvim-lua/plenary.nvim"},
        {"nvim-treesitter/nvim-treesitter"}
      },
      config = function()
        require('refactoring').setup({})
      end,
    }

    -- toggleterm
    use {
      "akinsho/toggleterm.nvim",
      config = function()
        require("nog.plugins.config.toggleterm").setup()
      end,
    }

    --
    -- END!
    --

    if packer_bootstrap then
      print "Restart Neovim required after installation!"
      require("packer").sync()
    end
  end

  packer_init()

  local packer = require "packer"
  packer.init(conf)
  packer.startup(plugins)
end

return M
