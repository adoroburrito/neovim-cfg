local M = {}

function M.setup()
  require("nvim-treesitter.configs").setup {
		endwise = {
			enable = true
		},
    -- A list of parser names, or "all"
    ensure_installed = { 
			-- web
			"javascript",
			"typescript",
			"json",
			"css",
			-- other languages
			"c", 
			"lua", 
			"rust",
			"c_sharp",
			"cpp",
			"go",
			"python",
			"bash",
			-- configuration files
			"yaml",
			"toml" 
		},

    -- Install languages synchronously (only applied to `ensure_installed`)
    sync_install = false,

    highlight = {
      -- `false` will disable the whole extension
      enable = true,
    },
  }
end

return M
