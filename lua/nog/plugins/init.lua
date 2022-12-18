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
    --[[
    use {
      "luisiacc/gruvbox-baby",
      config = function()
        vim.cmd "syntax on"
        vim.g.gruvbox_baby_function_style = "italic"
        vim.g.gruvbox_baby_keyword_style = "bold"
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
      end,
    }
    ]]--

    -- catppuccin
    use {
      "catppuccin/nvim",
      config = function()
        vim.g.catppuccin_flavour = "latte"
        require("catppuccin").setup({
          color_overrides = {
            latte = {
              base = "#ffffff",
            }
          },
          term_colors = false,
          dim_inactive = {
            enabled = false,
            shade = "dark",
            percentage = 0.15
          },
          integrations = {
            telescope = true,
            which_key = true,
            nvimtree = true,
            notify = true,
            aerial = true,
            hop = true,
            cmp = true,
            treesitter = true
          }
        })
        vim.cmd [[colorscheme catppuccin]]
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

    -- java stuff
    use {
      "mfussenegger/nvim-jdtls",
      config = function()
        require("nog.plugins.config.jdtls").setup()
      end,
      ft = 'java'
    }

    -- symbols navigation
    use {
      'stevearc/aerial.nvim',
      config = function() require('aerial').setup() end
    }

    -- show registers
    use "tversteeg/registers.nvim"

    -- hop around (visible characters of) buffer
    use {
      'phaazon/hop.nvim',
      branch = 'v2', -- optional but strongly recommended
      config = function()
        require('hop').setup()
      end
    }

    -- peek lines
    use {
      'nacro90/numb.nvim',
      config = function()
        require('numb').setup()
      end
    }

    -- markdown syntax highlighting
    use {
      'preservim/vim-markdown',
      config = function()
        vim.cmd [[set conceallevel=2]]
        vim.cmd [[let g:vim_markdown_folding_disabled = 1]]
      end
    }

    -- preview markdown + mermaidjs
    use({
        "iamcco/markdown-preview.nvim",
        run = function() 
          vim.cmd [[let g:mkdp_refresh_slow = 0]]
          vim.cmd [[let g:mkdp_preview_options.disable_sync_scroll = !g:mkdp_preview_options.disable_sync_scroll]]
          vim.fn["mkdp#util#install"]()
        end,
    })

    -- review github prs
    use {
      'pwntester/octo.nvim',
      requires = {
        'nvim-lua/plenary.nvim',
        'nvim-telescope/telescope.nvim',
        'kyazdani42/nvim-web-devicons',
      },
      config = function ()
        require"octo".setup()
      end
    }

    -- editor config
    use 'gpanders/editorconfig.nvim'

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
