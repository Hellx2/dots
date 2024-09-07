local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
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

vim.api.nvim_create_autocmd("InsertLeave", {
    callback = function(_)
        local buf = vim.api.nvim_win_get_buf(0)
        if vim.bo[buf].filetype == "TelescopePrompt" then
            require("telescope.actions").close(buf)
        end
    end,
})

local function load_plugins()
    require("lazy").setup({
        require("plugins.rainbow"),
        require("plugins.themes"),
        require("plugins.whichkey"),
        require("plugins.format"),
        require("plugins.comp"),
        require("plugins.tscope"),
        require("plugins.treesitter"),
        require("plugins.projects"),
        require("plugins.line"),
        require("plugins.dbg"),

        -- Always enabled section
        { "Myzel394/easytables.nvim", config = true },
        { "EtiamNullam/deferred-clipboard.nvim", config = true },
        { "akinsho/toggleterm.nvim", config = true },
        { "m4xshen/autoclose.nvim", config = true },
        { "cshuaimin/ssr.nvim", config = true },
        { "folke/neoconf.nvim", opts = {} },

        { "willothy/moveline.nvim", build = "make" },

        "famiu/bufdelete.nvim",

        -- Automatic indentation
        { "vidocqh/auto-indent.nvim", config = true, enabled = vim.g.settings.autoindent },

        -- Git section
        { "lewis6991/gitsigns.nvim", config = true, enabled = vim.g.settings.enabled.git },
        { "tpope/vim-fugitive", enabled = vim.g.settings.enabled.git },

        -- LSP section
        { "folke/neodev.nvim", config = true, enabled = vim.g.settings.enabled.lsp },
        { "mfussenegger/nvim-jdtls", ft = "java", enabled = vim.g.settings.enabled.lsp },
        { "mrcjkb/rustaceanvim", version = "^4", lazy = false, enabled = vim.g.settings.enabled.lsp },
        { "aznhe21/actions-preview.nvim", enabled = vim.g.settings.enabled.lsp },
        { "rmagatti/goto-preview", enabled = vim.g.settings.enabled.lsp },
        { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", config = true, enabled = vim.g.settings.enabled.lsp },

        {
            "ray-x/lsp_signature.nvim",
            event = "VeryLazy",
            opts = {},
            config = function(_, opts)
                require("lsp_signature").setup(opts)
            end,
            enabled = vim.g.settings.enabled.lsp,
        },

        --[[
        {
            "ray-x/go.nvim",
            dependencies = {
                "ray-x/guihua.lua",
                "neovim/nvim-lspconfig",
                "nvim-treesitter/nvim-treesitter",
            },
            config = function()
                require("go").setup()
            end,
            event = { "CmdlineEnter" },
            ft = { "go", "gomod" },
            build = ':lua require("go.install").update_all_sync()',
            enabled = vim.g.settings.enabled.lsp,
        },
        ]]

        -- Misc
        { "Bekaboo/dropbar.nvim", dependencies = "nvim-telescope/telescope-fzf-native.nvim" },
        { "vhyrro/luarocks.nvim", priority = 1000, config = true },
        { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
        { "CRAG666/code_runner.nvim", opts = { filetype = { go = { "go run $dir" } } } },
        { "otavioschwanck/arrow.nvim", opts = { show_icons = true, leader_key = ";", buffer_leader_key = "m" } },
        { "smjonas/inc-rename.nvim", main = "inc_rename", config = true },

        --{ "milkias17/reloader.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
        --{ "seandewar/nvimesweeper", opts = {} },
        --{ "folke/twilight.nvim", opts = {} },
        --{ "LintaoAmons/scratch.nvim", event = "VeryLazy" },

        { "Exafunction/codeium.vim", enabled = vim.g.settings.use_ai },

        "andweeb/presence.nvim",
        "RRethy/vim-illuminate",
        "VidocqH/lsp-lens.nvim",
        "NvChad/nvim-colorizer.lua",
        "jmbuhr/otter.nvim",
        "dstein64/nvim-scrollview",
        "voldikss/vim-floaterm",

        {
            "windwp/nvim-ts-autotag",
            ft = { "javascript", "html", "php", "xml", "jsx", "tsx", "markdown", "typescript" },
        },

        -- Auto save
        {
            "okuuva/auto-save.nvim",
            enabled = vim.g.settings.autosave,
            cmd = "ASToggle",
            event = { "InsertLeave", "TextChanged" },
            opts = {},
        },

        {
            "nvim-telescope/telescope-file-browser.nvim",
            dependencies = { "nvim-telescope/telescope.nvim", "nvim-lua/plenary.nvim" },
        },

        {
            "akinsho/bufferline.nvim",
            dependencies = "nvim-tree/nvim-web-devicons",
            opts = {
                options = {
                    close_command = "Bdelete %d",
                    right_mouse_command = "Bdelete %d",
                    hover = {
                        enabled = true,
                        delay = -1,
                        reveal = { "close" },
                    },
                    separator_style = "slant",
                    always_show_bufferline = true,
                    diagnostics = "nvim_lsp",
                },
            },
        },
        {
            "folke/trouble.nvim",
            config = function()
                require("trouble").setup({
                    open_no_results = true,
                })
                --require("trouble").open("diagnostics")
                vim.cmd("wincmd p")
            end,
        },

        {
            "nvim-treesitter/nvim-treesitter-context",
            main = "treesitter-context",
            opts = { mode = "topline", max_lines = 5 },
        },

        {
            "AckslD/nvim-neoclip.lua",
            dependencies = {
                { "kkharji/sqlite.lua", main = "sqlite" },
                { "nvim-telescope/telescope.nvim" },
            },
            opts = {
                enable_persistent_history = true,
            },
        },
        {
            "neovim/nvim-lspconfig",
            dependencies = {
                { "williamboman/mason.nvim", opts = {} },
                { "williamboman/mason-lspconfig.nvim", opts = {} },
                { "folke/neodev.nvim", opts = {} },
            },
        },

        {
            "folke/noice.nvim",
            opts = {
                lsp = {
                    override = {
                        ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                        ["vim.lsp.util.stylize_markdown"] = true,
                        ["cmp.entry.get_documentation"] = true,
                    },
                    signature = {
                        enabled = false,
                    },
                },
                presets = {
                    bottom_search = true, -- use a classic bottom cmdline for search
                    command_palette = true, -- position the cmdline and popupmenu together
                    long_message_to_split = true, -- long messages will be sent to a split
                    inc_rename = false, -- enables an input dialog for inc-rename.nvim
                    lsp_doc_border = false, -- add a border to hover docs and signature help
                },
            },
        },
        {
            "kevinhwang91/nvim-ufo",
            dependencies = "kevinhwang91/promise-async",
            opts = {
                provider_selector = function(_, _, _)
                    return { "treesitter", "indent" }
                end,
            },
        },
        {
            "rcarriga/nvim-notify",
            config = function()
                require("notify").setup({
                    fps = 60,
                    stages = "fade",
                    timeout = 2000,
                    top_down = false,
                })
            end,
        },

        {
            "folke/todo-comments.nvim",
            dependencies = { "nvim-lua/plenary.nvim" },
            opts = {},
        },

        {
            "MeanderingProgrammer/markdown.nvim",
            main = "render-markdown",
            opts = {},
            name = "render-markdown", -- Only needed if you have another plugin named markdown.nvim
            dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
            -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
            -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
        },

        -- Tree section
        {
            "nvim-neo-tree/neo-tree.nvim",
            dependencies = { "MunifTanjim/nui.nvim", "folke/trouble.nvim" },
            opts = {
                close_if_last_window = true,
                default_component_configs = {
                    file_size = {
                        enabled = false,
                    },
                    type = {
                        enabled = true,
                        required_width = 20,
                    },
                    indent = {
                        with_expanders = true,
                        expander_collapsed = "",
                        expander_expanded = "",
                        expander_highlight = "NeoTreeExpander",
                    },
                },
            },
            config = function(opts)
                require("neo-tree").setup(opts)

                vim.schedule(function()
                    vim.cmd({ cmd = "Neotree", args = { "action=show" } })
                end)
            end,
            enabled = vim.g.settings.enabled.tree,
        },

        {
            "iamcco/markdown-preview.nvim",
            cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
            ft = { "markdown" },
            build = function()
                vim.fn["mkdp#util#install"]()
            end,
        },

        {
            "NeogitOrg/neogit",
            dependencies = { "nvim-lua/plenary.nvim", "sindrets/diffview.nvim", "nvim-telescope/telescope.nvim" },
            config = true,
        },
    })
end

load_plugins()
