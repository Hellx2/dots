return {
    "nvim-treesitter/nvim-treesitter",
    opts = {
        ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript" },
        auto_install = true,
        highlight = { enable = true, additional_vim_regex_highlighting = false },
        incremental_selection = {
            enable = true,
            keymaps = {
                init_selection = "<C-n>",
                node_incremental = "<C-n>",
                scope_incremental = "<C-s>",
                node_decremental = "<C-m>",
            },
        },
        tree_docs = {
            enable = true,
            spec_config = {
                jsdoc = {
                    slots = {
                        class = {
                            author = true,
                        },
                    },
                    processors = {
                        author = function()
                            return " * @author Hellx2"
                        end,
                    },
                },
            },
        },
        autotag = {
            enable = true,
        },
    },
    config = function(opts)
        local configs = require("nvim-treesitter.configs")
        require("nvim-treesitter").setup(opts)
        configs.setup(opts)
    end,
}
