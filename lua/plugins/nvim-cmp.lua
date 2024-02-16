local packer = require('packer')

packer.use{'hrsh7th/nvim-cmp',
    requires = {
        'neovim/nvim-lspconfig',
        'hrsh7th/cmp-nvim-lsp',
        'hrsh7th/cmp-nvim-lsp-signature-help',
        --'hrsh7th/cmp-buffer',
        'L3MON4D3/LuaSnip',
        'saadparwaiz1/cmp_luasnip',
    },
    config = function()
        local lspconfig = require('lspconfig')
        local cmp = require('cmp')
        local cmp_nvim_lsp = require('cmp_nvim_lsp')
        local luasnip = require('luasnip')

        for _, server in ipairs({'clangd', 'pylsp'}) do
            lspconfig[server].setup{
                capabilities = cmp_nvim_lsp.default_capabilities(),
            }
        end

        cmp.setup{
            sources = {
                { name = 'nvim_lsp' },
                { name = 'nvim_lsp_signature_help' },
                --{ name = 'buffer' },
                { name = 'luasnip' },
            },
            snippet = {
                expand = function(args)
                    luasnip.lsp_expand(args.body)
                end,
            },
            mapping = cmp.mapping.preset.insert{
                ['<CR>'] = cmp.mapping.confirm{select=true},
                ['<Tab>'] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            if #cmp.get_entries() == 1 then
                                cmp.confirm{select=true}
                            else
                                cmp.select_next_item()
                            end
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        else
                            fallback()
                        end
                    end,
                    { 'i', 's' }
                ),
                ['<S-Tab>'] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end,
                    {'i', 's'}
                ),
                ['<C-l>'] = cmp.mapping(
                    function(fallback)
                        if luasnip.jumpable(1) then
                            luasnip.jump(1)
                        else
                            fallback()
                        end
                    end,
                    {'i', 's'}
                ),
                ['<C-h>'] = cmp.mapping(
                    function(fallback)
                        if luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end,
                    {'i', 's'}
                ),
                ['<C-j>'] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        else
                            fallback()
                        end
                    end,
                    {'i', 's'}
                ),
                ['<C-k>'] = cmp.mapping(
                    function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        else
                            fallback()
                        end
                    end,
                    {'i', 's'}
                ),
            },
        }
    end,
}
