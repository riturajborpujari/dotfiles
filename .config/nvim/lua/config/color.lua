require("onedark").setup({
  style = "dark",
  transparent = true,
  term_colors = true
})
require("onedark").load()

vim.api.nvim_set_hl(0, "ColorColumn", { bg = "#28282D", fg = "NONE" })
vim.api.nvim_set_hl(0, "LineNr", { bg = "NONE", fg = "#E5C07B"})
vim.api.nvim_set_hl(0, "LineNrBelow", { bg = "NONE", fg = "#666666"})
vim.api.nvim_set_hl(0, "LineNrAbove", { bg = "NONE", fg = "#666666"})
