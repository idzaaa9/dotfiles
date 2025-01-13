vim.opt.clipboard = 'unnamed'

local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

local on_attach = function(_, _)
  vim.keymap.set('n', '<leader>rn', vim.lsp.buf.rename, {})
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, {})

  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, {})
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, {})
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, {})
  vim.keymap.set('n', 'gr', require("telescope.builtin").lsp_references, {})
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, {})
end

require("lazy").setup({
{
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    opts = {
      highlight = { enable = true },
    },
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },
  {
    "nvim-neorg/neorg",
    tag = "v7.0.0",
    build = ":Neorg sync-parsers",
    dependencies = { "nvim-lua/plenary.nvim" },
    config = function()
      require("neorg").setup {
        load = {
          ["core.export"] = {},
          ["core.defaults"] = {},
          ["core.concealer"] = {},
          ["core.dirman"] = {
            config = {
              workspaces = {
                notes = "~/notes",
                usi_predavanja = "~/faks/usi/predavanja",
                pp_predavanja = "~/faks/pp/predavanja"
              },
              default_workspace = "notes",
            },
          },
          --["core.ui.calendar"] = {}
        },
      }

      vim.wo.foldlevel = 99
      vim.wo.conceallevel = 2
    end,
  },
  {"ellisonleao/gruvbox.nvim", priority = 1000 , config = true, opts = ...},
  {
    "brenoprata10/nvim-highlight-colors",
    config = function()
      require("nvim-highlight-colors").setup {}
    end,
  },
  {
    "nekonako/xresources-nvim"
  },
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    config = function()
      require("lualine").setup {
        options = {
          icons_enabled = false,
          theme = "gruvbox"
        }
      }
    end,
  },
  {
    "nvim-telescope/telescope.nvim",
    dependencies = { "nvim-lua/plenary.nvim" }
  },
  {
    "neovim/nvim-lspconfig",
    config = function()
      local capabilities = require("cmp_nvim_lsp").default_capabilities(),
      require("lspconfig").lua_ls.setup ({
        on_attach = on_attach,
        capabilities = capabilities
      })
      require("lspconfig").clangd.setup ({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      require("lspconfig").omnisharp.setup ({
        on_attach = on_attach,
        capabilities = capabilities,
      })
      end,

  },
  {
    "williamboman/mason.nvim",
    config = function()
      require("mason").setup ()
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    config = function()
      require("mason-lspconfig").setup ({
      	ensure_installed = { "lua_ls" }
      })
    end,
  },
  {
    "hrsh7th/nvim-cmp",
    config = function ()
      local cmp = require("cmp")
      cmp.setup ({
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
        }),
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim-lsp" },
          { name = "luasnip" },
        }, {
          { name = "buffer" },
        })
      })
    end,
  },
  {
    "hrsh7th/cmp-nvim-lsp",
  },
  {
    "L3MON4D3/LuaSnip",
  }
})

local builtin = require('telescope.builtin')
vim.keymap.set('n', '<leader>ff', builtin.find_files, {})
vim.keymap.set('n', '<leader>fg', builtin.live_grep, {})
vim.keymap.set('n', '<leader>fb', builtin.buffers, {})
vim.keymap.set('n', '<leader>fh', builtin.help_tags, {})

local set = vim.opt
set.tabstop = 2
set.shiftwidth = 2
set.expandtab = true
set.number = true
set.relativenumber = true

-- local twilight = require('twilight')

-- twilight.setup({
  -- style = "dark"
-- })

-- twilight.load()

vim.o.background = "dark"
vim.cmd([[colorscheme gruvbox]])
require('xresources')

