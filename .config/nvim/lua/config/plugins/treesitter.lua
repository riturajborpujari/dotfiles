return {
	'nvim-treesitter/nvim-treesitter',
	build = ":TSUpdate",
	config = function()
		local configs = require("nvim-treesitter.configs")

		configs.setup({
      ensure_installed = { "c", "cpp", "vim", "vimdoc", "javascript",
        "typescript", "rust", "lua", "bash", "go" },
			sync_install = false,
			highlight = {
        enable = true,
        additional_vim_regex_highlighting = {"markdown"}
      },
			indent = { enable = true }
		})
	end
}
