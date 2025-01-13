vim.cmd([[colorscheme gruvbox]])
require('xresources')

vim.g.copilot_filetypes = { text = false }

require('go').setup()

local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*.go",
  callback = function()
   require('go.format').goimports()
  end,
  group = format_sync_grp,
})
