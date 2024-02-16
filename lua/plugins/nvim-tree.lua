local packer = require('packer')

packer.use{'nvim-tree/nvim-tree.lua',
    config = function()
        require('nvim-tree').setup{}
    end,
}
