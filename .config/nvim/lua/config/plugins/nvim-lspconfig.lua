return {
  "neovim/nvim-lspconfig",
  dependencies = {
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },

  config = function()
    local cmp = require('cmp')
    local lspconfig = require("lspconfig")
    local cmp_lsp = require("cmp_nvim_lsp")
    local capabilities = cmp_lsp.default_capabilities()

    local servers = { 'clangd', 'rust_analyzer', 'pyright', 'tsserver', 'gopls' }
    for _, lsp in ipairs(servers) do
      lspconfig[lsp].setup {
        capabilities = capabilities
      }
    end

    cmp.setup({
      mapping = cmp.mapping.preset.insert({
        ['<C-p>'] = cmp.mapping.select_prev_item(),
        ['<C-n>'] = cmp.mapping.select_next_item(),
        ['<cr>'] = cmp.mapping.confirm({ select = true, behavior = cmp.SelectBehavior.Replace }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ['<Tab>'] = cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.select_next_item()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>']= cmp.mapping(function (fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          else
            fallback()
          end
        end, {'i', 's' })
      }),
      sources = cmp.config.sources({
        { name = 'nvim_lsp' },
      }, {
        { name = 'buffer' },
      })
    })

    vim.diagnostic.config({
      -- update_in_insert = true,
      float = {
        focusable = false,
        style = "minimal",
        source = "always",
        header = "",
        prefix = "",
      },
    })
  end
}
