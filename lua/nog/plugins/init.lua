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
      "folke/tokyonight.nvim",
      config = function()
				vim.g.tokyonight_style = "night"
				vim.g.tokyonight_transparent = true
				vim.g.tokyonight_italic_functions = true
        vim.cmd "colorscheme tokyonight"
        vim.cmd "syntax on"
      end,
    }

		-- IndentLine
		use {
			"lukas-reineke/indent-blankline.nvim",
			event = "BufReadPre",
			config = function()
				require("nog.plugins.config.indentblankline").setup()
			end,
		}

		-- Better icons
		use {
			"kyazdani42/nvim-web-devicons",
			module = "nvim-web-devicons",
			config = function()
				require("nvim-web-devicons").setup { default = true }
			end,
		}

		-- StatusLine
		use {
			"nvim-lualine/lualine.nvim",
			event = "VimEnter",
			config = function()
			 require("nog.plugins.config.lualine").setup()
			end,
			requires = { "nvim-web-devicons" },
		}

		-- WhichKey
		use {
			 "folke/which-key.nvim",
			 event = "VimEnter",
			 config = function()
				 require("nog.plugins.config.whichkey").setup()
			 end,
		}

		-- Easy hopping
		use {
			"phaazon/hop.nvim",
			cmd = { "HopWord", "HopChar1" },
			config = function()
				require("hop").setup {}
			end,
		}

		-- File Explorer
		use {
		 "kyazdani42/nvim-tree.lua",
		 requires = {
			 "kyazdani42/nvim-web-devicons",
		 },
		 cmd = { "NvimTreeToggle", "NvimTreeClose" },
			 config = function()
				 require("nog.plugins.config.nvimtree").setup()
			 end,
		}

		-- Fzf support
		use { 'ibhagwan/fzf-lua',
			-- optional for icon support
			requires = { 'kyazdani42/nvim-web-devicons' }
		}

		-- User interface
		use {
			"stevearc/dressing.nvim",
			event = "BufEnter",
			config = function()
				require("dressing").setup {
					select = {
						backend = { "telescope", "fzf", "builtin" },
					},
				}
			end,
		}
		use { "nvim-telescope/telescope.nvim", module = "telescope", as = "telescope" }

		-- Buffer line
		use {
			"akinsho/nvim-bufferline.lua",
			event = "BufReadPre",
			wants = "nvim-web-devicons",
			config = function()
				require("nog.plugins.config.bufferline").setup()
			end,
		}

		-- Treesitter
		use {
			"nvim-treesitter/nvim-treesitter",
			opt = true,
			event = "BufRead",
			run = ":TSUpdate",
			config = function()
				require("nog.plugins.config.treesitter").setup()
			end,
		}

    -- LSP
    use {
      "neovim/nvim-lspconfig",
      opt = true,
      event = "BufReadPre",
      wants = { "cmp-nvim-lsp", "nvim-lsp-installer", "lsp_signature.nvim" },
      config = function()
        require("nog.plugins.config.lsp").setup()
      end,
      requires = {
        "williamboman/nvim-lsp-installer",
        "ray-x/lsp_signature.nvim",
      },
    }

    -- nvim-cmp
    use {
      "hrsh7th/nvim-cmp",
      event = "InsertEnter",
      opt = true,
      config = function()
        require("nog.plugins.config.cmp").setup()
      end,
      wants = { "LuaSnip" },
      requires = {
        "hrsh7th/cmp-buffer",
        "hrsh7th/cmp-path",
        "hrsh7th/cmp-nvim-lua",
        "ray-x/cmp-treesitter",
        "hrsh7th/cmp-cmdline",
        "saadparwaiz1/cmp_luasnip",
        "hrsh7th/cmp-nvim-lsp",
        {
          "L3MON4D3/LuaSnip",
          wants = "friendly-snippets",
          config = function()
            require("nog.plugins.config.luasnip").setup()
          end,
        },
        "rafamadriz/friendly-snippets",
      },
      disable = false,
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
