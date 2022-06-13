local packer = require 'lib.packer-init'

packer.startup(function(use)
    use { 'wbthomason/packer.nvim' }

    use {
        'L3MON4D3/LuaSnip',
        config = function()
            require('user.plugins.luasnip')
        end
    }

    use {
        'hrsh7th/nvim-cmp',
        requires = {
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-cmdline',
            'L3MON4D3/LuaSnip',
            'saadparwaiz1/cmp_luasnip',
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-nvim-lua',
            'onsails/lspkind-nvim',
            --'onsails/lspkind-nvim',
            --'hrsh7th/cmp-nvim-lsp-signature-help',
            'f3fora/cmp-spell',
        },
        config = function()
            require('user.plugins.cmp')
        end
    }

   -- use {
   --     'uga-rosa/cmp-dictionary',
   --      requires = {
   --          'hrsh7th/nvim-cmp'
   --      },
   --     config = function ()
   --         require('user.plugins.cmp-dictionary')
   --     end
   -- }

    use {
        'neovim/nvim-lspconfig',
        requires = {
            --'b0o/schemastore.nvim',
            --'folke/lsp-colors.nvim',
            --'weilbith/nvim-code-action-menu',
        },
        config = function ()
            require('user.plugins.lspconfig')
        end
    }

    use {
        'nvim-telescope/telescope.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
            { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
        },
        config = function ()
            require('user.plugins.telescope')
        end
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        requires = {
            --'nvim-treesitter/nvim-treesitter-textobjects',
            'lewis6991/spellsitter.nvim',
            'JoosepAlviste/nvim-ts-context-commentstring',
        },
        config = function()
            require('user.plugins.treesitter')
            require('spellsitter').setup()
        end
    }

    use {
        'jose-elias-alvarez/null-ls.nvim',
        requires = {
            { 'nvim-lua/plenary.nvim' },
        },
        config = function ()
            require('user.plugins.null-ls')
        end
    }

    -- Requires: `xdotool`
    use {
        'lervag/vimtex',
        config = function ()
            require('user.plugins.vimtex')
        end
    }

    use { 'tpope/vim-commentary' }

    use {
        'norcalli/nvim-colorizer.lua',
        config = function ()
            require'colorizer'.setup()
        end
    }

    use {
        'lewis6991/gitsigns.nvim',
        config = function()
            require('user.plugins.gitsigns')
        end
    }
    
    use {
        'RRethy/nvim-base16' ,
        config = function ()
            require 'user.base16'
        end
    }
end)
