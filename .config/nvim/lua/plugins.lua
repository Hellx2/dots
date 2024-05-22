--[[require("nvim-treesitter.configs").setup({
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
})]]
--

--[[ Trouble
require("trouble").setup({})
require("trouble").open()
vim.cmd("wincmd p")
]]
--

--[[ Color --
require("colorizer").setup({})

require("deferred-clipboard").setup({})
]]
--

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
    {
        "nvim-telescope/telescope.nvim",
        dependencies = { "nvim-lua/plenary.nvim", "nvim-tree/nvim-web-devicons" },
        opts = {
            extensions = {
                fzf = {
                    fuzzy = true,
                    override_generic_sorter = true,
                    override_file_sorter = true,
                    case_mode = "smart_case",
                },
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
    "neovim/nvim-lspconfig",
    --[[{
		"utilyre/barbecue.nvim",
		name = "barbecue",
		version = "*",
		dependencies = {
			"SmiteshP/nvim-navic",
			"nvim-tree/nvim-web-devicons", -- optional dependency
		},
		opts = {
			-- configurations go here
		},
	},]]
    --
    { "m4xshen/autoclose.nvim", config = true },
    {
        "folke/trouble.nvim",
        config = function()
            require("trouble").setup({})
            require("trouble").open()
            vim.cmd("wincmd p")
        end,
    },
    "mrcjkb/rustaceanvim",
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
        config = function()
            require("eagle").setup({
                -- override the default values found in config.lua
            })
            -- make sure mousemoveevent is enabled
            vim.o.mousemoveevent = true
        end,
    },
    {
        "nvim-treesitter/nvim-treesitter",
        opts = {
            --ensure_installed = { "c", "lua", "vim", "vimdoc", "query", "python", "javascript" },
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
    },
    {
        "kevinhwang91/nvim-ufo",
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
    {
        "mhartington/formatter.nvim",
        config = function()
            vim.cmd([[
                augroup FormatAutogroup
                    autocmd!
                    autocmd BufWritePost * FormatWrite
                augroup END
            ]])
            local util = require("formatter.util")
            require("formatter").setup({
                logging = true,
                log_level = vim.log.levels.WARN,
                filetype = {
                    lua = {
                        require("formatter.filetypes.lua").stylua,

                        function()
                            if util.get_current_buffer_file_name() == "special.lua" then
                                return nil
                            end

                            return {
                                exe = "stylua",
                                args = {
                                    "--search-parent-directories",
                                    "--indent-type=Spaces",
                                    "--stdin-filepath",
                                    util.escape_path(util.get_current_buffer_file_path()),
                                    "--",
                                    "-",
                                },
                                stdin = true,
                            }
                        end,
                    },

                    rust = {
                        require("formatter.filetypes.rust").rustfmt,
                    },

                    html = {
                        function()
                            return {
                                exe = "prettier",
                                args = {
                                    "--tab-width=4",
                                    util.escape_path(util.get_current_buffer_file_path()),
                                },
                                stdin = true,
                                try_node_modules = true,
                            }
                        end,
                    },

                    css = {
                        function()
                            return {
                                exe = "prettier",
                                args = {
                                    "--tab-width=4",
                                    util.escape_path(util.get_current_buffer_file_path()),
                                },
                                stdin = true,
                                try_node_modules = true,
                            }
                        end,
                    },

                    php = {
                        require("formatter.defaults.prettier"),
                    },

                    ["*"] = {
                        require("formatter.filetypes.any").remove_trailing_whitespace,
                    },
                },
            })
        end,
    },
    {
        "hrsh7th/nvim-cmp",
        dependencies = {
            "L3MON4D3/LuaSnip",
            "onsails/lspkind.nvim",
            "lukas-reineke/cmp-under-comparator",
            "SergioRibera/cmp-dotenv",
            "saadparwaiz1/cmp_luasnip",
            "hrsh7th/cmp-nvim-lsp",
            "hrsh7th/cmp-nvim-lua",
            "hrsh7th/cmp-path",
        },
        config = function()
            local luasnip = require("luasnip")
            luasnip.config.setup({})

            local cmp = require("cmp")

            local has_words_before = function()
                unpack = unpack or table.unpack
                local line, col = unpack(vim.api.nvim_win_get_cursor(0))
                return col ~= 0
                    and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
            end

            cmp.setup({
                snippet = {
                    expand = function(args)
                        luasnip.lsp_expand(args.body)
                    end,
                },
                completion = {
                    keyword_length = 1,
                },
                mapping = cmp.mapping.preset.insert({
                    ["<Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_next_item()
                        elseif luasnip.expand_or_jumpable() then
                            luasnip.expand_or_jump()
                        elseif has_words_before() then
                            cmp.complete()
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<s-Tab>"] = cmp.mapping(function(fallback)
                        if cmp.visible() then
                            cmp.select_prev_item()
                        elseif luasnip.jumpable(-1) then
                            luasnip.jump(-1)
                        else
                            fallback()
                        end
                    end, { "i", "s" }),
                    ["<c-e>"] = cmp.mapping.abort(),
                    ["<CR>"] = cmp.mapping.confirm({ select = true }),
                }),
                sources = {
                    { name = "nvim_lsp", keyword_length = 1 },
                    { name = "luasnip", keyword_length = 1 },
                    { name = "codeium" },
                    { name = "dotenv" },
                    { name = "path", option = { trailing_slash = true } },
                    { name = "nvim_lua" },
                },
                formatting = {
                    format = require("lspkind").cmp_format({
                        mode = "symbol",
                        maxwidth = 50,
                        ellipsis_char = "...",
                        symbol_map = {
                            Text = "󰉿",
                            Method = "󰆧",
                            Function = "󰊕",
                            Constructor = "",
                            Field = "󰜢",
                            Variable = "󰀫",
                            Class = "󰠱",
                            Interface = "",
                            Module = "",
                            Property = "󰜢",
                            Unit = "󰑭",
                            Value = "󰎠",
                            Enum = "",
                            Keyword = "󰌋",
                            Snippet = "",
                            Color = "󰏘",
                            File = "󰈙",
                            Reference = "󰈇",
                            Folder = "󰉋",
                            EnumMember = "",
                            Constant = "󰏿",
                            Struct = "󰙅",
                            Event = "",
                            Operator = "󰆕",
                            TypeParameter = "",
                            Codeium = "",
                        },
                    }),
                },
                sorting = {
                    comparators = {
                        cmp.config.compare.offset,
                        cmp.config.compare.exact,
                        cmp.config.compare.score,
                        require("cmp-under-comparator").under,
                        cmp.config.compare.kind,
                        cmp.config.compare.sort_text,
                        cmp.config.compare.length,
                        cmp.config.compare.order,
                    },
                },
                performance = {
                    debounce = 0,
                },
            })
        end,
    },
    {
        "catppuccin/nvim",
        priority = 1000,
        config = function()
            vim.cmd.colorscheme("catppuccin")
        end,
    },
    { "Exafunction/codeium.nvim", dependencies = "Exafunction/codeium.vim" },
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
})
