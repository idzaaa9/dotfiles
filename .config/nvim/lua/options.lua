-- tabulation
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

-- line number
vim.opt.number = true
vim.opt.relativenumber = true

-- clipboard
vim.opt.clipboard = 'unnamed'

-- colorscheme
vim.o.background = "dark"

-- html autocompletion
vim.cmd[[
  autocmd FileType html set omnifunc=htmlcomplete#CompleteTags
]]
