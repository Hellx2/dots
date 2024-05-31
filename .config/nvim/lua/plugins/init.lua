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

--local actions = require("telescope.actions")

require("lazy").setup({
    require("plugins.themes"),
    { "Myzel394/easytables.nvim", config = true },
    "tpope/vim-fugitive",
    {
        "jbyuki/instant.nvim",
        config = function()
            vim.g.instant_username = "Hellx2"
        end,
    },
    { "niuiic/code-shot.nvim", dependencies = "niuiic/core.nvim", config = true },
    { "krivahtoo/silicon.nvim", build = "./install.sh", opts = {} },
    {
        "vidocqh/auto-indent.nvim",
        opts = {},
    },
    {
        "gnikdroy/projections.nvim",
        config = function()
            require("projections").setup({
                workspaces = {},
            })
        end,
    },
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
    },
    { "seandewar/nvimesweeper", opts = {} },
    {
        "nvim-orgmode/orgmode",
        event = "VeryLazy",
        ft = { "org" },
        config = function()
            -- Setup orgmode
            require("orgmode").setup({
                org_agenda_files = "~/orgfiles/**/*",
                org_default_notes_file = "~/orgfiles/refile.org",
                mappings = {
                    global = {
                        org_agenda = "<C-o>",
                    },
                },
            })

            -- NOTE: If you are using nvim-treesitter with `ensure_installed = "all"` option
            -- add `org` to ignore_install
            -- require('nvim-treesitter.configs').setup({
            --   ensure_installed = 'all',
            --   ignore_install = { 'org' },
            -- })
        end,
    },
    {
        "RutaTang/quicknote.nvim",
        config = function()
            -- you must call setup to let quicknote.nvim works correctly
            require("quicknote").setup({})
        end,
        dependencies = { "nvim-lua/plenary.nvim" },
    },
    {
        "koenverburg/peepsight.nvim",
        opts = {
            -- go
            "function_declaration",
            "method_declaration",
            "func_literal",

            -- typescript
            "class_declaration",
            "method_definition",
            "arrow_function",
            "function_declaration",
            "generator_function_declaration",
        },
    },
    { "milkias17/reloader.nvim", dependencies = { "nvim-lua/plenary.nvim" } },
    {
        "willothy/moveline.nvim",
        build = "make",
    },
    {
        "gen740/SmoothCursor.nvim",
        config = function()
            require("smoothcursor").setup()
        end,
    },
    require("plugins.whichkey"),
    {
        "LintaoAmons/scratch.nvim",
        event = "VeryLazy",
    },
    {
        "kylechui/nvim-surround",
        version = "*", -- Use for stability; omit to use `main` branch for the latest features
        event = "VeryLazy",
        config = function()
            require("nvim-surround").setup({})
        end,
    },
    {
        "otavioschwanck/arrow.nvim",
        opts = {
            show_icons = true,
            leader_key = ";", -- Recommended to be a single key
            buffer_leader_key = "m", -- Per Buffer Mappings
        },
    },
    "famiu/bufdelete.nvim",
    {
        "CRAG666/code_runner.nvim",
        opts = {
            filetype = {
                go = {
                    "go run $dir",
                },
            },
        },
    },
    "andweeb/presence.nvim",
    {
        "sainnhe/edge",
        config = function()
            --vim.cmd.colorscheme("edge")
        end,
    },
    {
        "cshuaimin/ssr.nvim",
        main = "ssr",
        -- Calling setup is optional.
        config = function()
            require("ssr").setup({
                border = "rounded",
                min_width = 50,
                min_height = 5,
                max_width = 120,
                max_height = 25,
                adjust_window = true,
                keymaps = {
                    close = "q",
                    next_match = "n",
                    prev_match = "N",
                    replace_confirm = "<cr>",
                    replace_all = "<leader><cr>",
                },
            })
        end,
    },
    {
        "folke/twilight.nvim",
        opts = {},
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
    "edluffy/hologram.nvim",
    "RRethy/vim-illuminate",
    { "ellisonleao/glow.nvim", config = true, cmd = "Glow" },
    --[[{
        "pwntester/octo.nvim",
        dependencies = {
            "nvim-lua/plenary.nvim",
            "nvim-telescope/telescope.nvim",
            -- OR 'ibhagwan/fzf-lua',
            "nvim-tree/nvim-web-devicons",
        },
        config = function()
            require("octo").setup()
        end,
    },]]
    --
    {
        "vhyrro/luarocks.nvim",
        priority = 1000,
        config = true,
    },
    {
        "lewis6991/gitsigns.nvim",
        config = true,
    },
    {
        "nvim-neorg/neorg",
        dependencies = { "luarocks.nvim", "pysan3/pathlib.nvim" },
        lazy = false, -- Disable lazy loading as some `lazy.nvim` distributions set `lazy = true` by default
        version = "*", -- Pin Neorg to the latest stable release
        config = true,
    },
    require("plugins.palette"),
    {
        "williamboman/mason.nvim",
        opts = {},
    },
    "mfussenegger/nvim-lint",
    {
        "neovim/nvim-lspconfig",
        dependencies = {
            { "williamboman/mason.nvim", opts = {} },
            { "williamboman/mason-lspconfig.nvim", opts = {} },
            { "folke/neodev.nvim", opts = {} },
        },
    },

    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
        opts = {
            defaults = {
                prompt_prefix = "🔎 ",
            },
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
            },
            pickers = {
                find_files = { theme = "dropdown" },
                filetypes = { theme = "dropdown" },
                neoclip = { theme = "dropdown" },
                current_buffer_fuzzy_find = { theme = "dropdown" },
                diagnostics = { theme = "dropdown" },
                lsp_references = { theme = "dropdown" },
                oldfiles = { theme = "dropdown" },
            },
        },
        config = function(_, opts)
            require("telescope").setup(opts)
        end,
    },
    {
        "Bekaboo/dropbar.nvim",
        -- optional, but required for fuzzy finder support
        dependencies = {
            "nvim-telescope/telescope-fzf-native.nvim",
        },
    },
    { "EtiamNullam/deferred-clipboard.nvim", config = true },
    "NvChad/nvim-colorizer.lua",
    { "akinsho/toggleterm.nvim", version = "*", config = true },
    {
        "okuuva/auto-save.nvim",
        cmd = "ASToggle", -- optional for lazy loading on command
        event = { "InsertLeave", "TextChanged" }, -- optional for lazy loading on trigger events
        opts = {},
    },
    { "https://git.sr.ht/~whynothugo/lsp_lines.nvim", config = true },
    { "folke/neodev.nvim", opts = {} },
    { "m4xshen/autoclose.nvim", config = true },
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({})
            require("trouble").open()
            vim.cmd("wincmd p")
        end,
    },
    { "mrcjkb/rustaceanvim", version = "^4", lazy = false },
    "beauwilliams/statusline.lua",
    "aznhe21/actions-preview.nvim",
    "rmagatti/goto-preview",
    "VidocqH/lsp-lens.nvim",
    {
        "akinsho/bufferline.nvim",
        dependencies = "nvim-tree/nvim-web-devicons",
    },
    { "windwp/nvim-ts-autotag" },
    {
        "folke/noice.nvim",
        opts = {
            lsp = {
                -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
                override = {
                    ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
                    ["vim.lsp.util.stylize_markdown"] = true,
                    ["cmp.entry.get_documentation"] = true, -- requires hrsh7th/nvim-cmp
                },
                signature = {
                    enabled = false,
                },
            },
            -- you can enable a preset for easier configuration
            presets = {
                bottom_search = true, -- use a classic bottom cmdline for search
                command_palette = true, -- position the cmdline and popupmenu together
                long_message_to_split = true, -- long messages will be sent to a split
                inc_rename = false, -- enables an input dialog for inc-rename.nvim
                lsp_doc_border = false, -- add a border to hover docs and signature help
            },
        },
    },
    "jmbuhr/otter.nvim",
    {
        "soulis-1256/eagle.nvim",
    },
    require("plugins.treesitter"),
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
                level = 2,
                minimum_width = 50,
                timeout = 2000,
                top_down = false,
            })
        end,
    },
    {
        "nvim-neo-tree/neo-tree.nvim",
        dependencies = { "MunifTanjim/nui.nvim" },
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
            },
        },
    },
    require("plugins.format"),
    require("plugins.comp"),
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    --{ "Exafunction/codeium.nvim", dependencies = "Exafunction/codeium.vim" },
    {
        "ray-x/lsp_signature.nvim",
        event = "VeryLazy",
        opts = {},
        config = function(_, opts)
            require("lsp_signature").setup(opts)
        end,
    },
    "dstein64/nvim-scrollview",
    "voldikss/vim-floaterm",
    {
        "iamcco/markdown-preview.nvim",
        cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
        ft = { "markdown" },
        build = function()
            vim.fn["mkdp#util#install"]()
        end,
    },
    { "lukas-reineke/indent-blankline.nvim", main = "ibl", opts = {} },
    {
        "nvim-pack/nvim-spectre",
        dependencies = "nvim-lua/plenary.nvim",
        opts = { open_cmd = "FloatingWin 100 15 215 2" },
    },
    {
        "nvim-treesitter/nvim-treesitter-context",
        main = "treesitter-context",
        config = true,
    },
})
