local vim = vim
local Plug = vim.fn['plug#']

vim.call('plug#begin')

Plug('shaunsingh/nord.nvim')
-- Plug('rebelot/kanagawa.nvim')
Plug('kyazdani42/nvim-tree.lua')
Plug('kyazdani42/nvim-web-devicons')
Plug('romgrk/barbar.nvim')
Plug('nvim-lualine/lualine.nvim')

vim.call('plug#end')

home = os.getenv('HOME')
package.path = home .. '/.config/nvim/?.lua;' .. package.path

vim.cmd[[colorscheme nord]]

require 'common'
require 'tree'
require 'barbar'
require 'lua_line'

