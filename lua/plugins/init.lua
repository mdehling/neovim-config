local configured, packer = pcall(require, 'packer')

if not configured then
    vim.fn.system{
        'git', 'clone', '--depth', '1',
        'https://github.com/wbthomason/packer.nvim',
        vim.fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
    }
    vim.cmd('packadd packer.nvim')
    packer = require('packer')
end

packer.init{}

packer.use{'wbthomason/packer.nvim'}
packer.use{'gpanders/editorconfig.nvim'}

require('plugins.nvim-tree')
require('plugins.nvim-cmp')

if not configured then
    packer.sync()
end
