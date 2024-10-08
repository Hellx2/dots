--[[
require("noice").setup({
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
})]]
--

vim.cmd([[
    hi Function gui=italic
    hi @keyword.return gui=italic guifg=#aaaaff
    hi Repeat gui=italic
    hi Keyword gui=italic
    hi String gui=italic
    hi Type gui=italic
    hi DiagnosticUnderlineError gui=undercurl
    hi DiagnosticUnderlineWarn gui=undercurl
    hi CmpItemAbbrMatch guifg=#ffffff gui=italic
    hi CmpItemAbbr guifg=#5c5c5c gui=italic
    hi @variable.builtin guifg=#eeab3d
    hi LspInlayHint guibg=none
    hi Macro gui=italic
    hi @keyword.function gui=italic
    hi Include gui=italic
    hi @variable guifg=#bbbbff
]])

-- Telescope
vim.cmd([[
    hi TelescopeNormal guifg=#ffffff guibg=#1c1c1c
    hi TelescopeBorder guifg=#1c1c1c guibg=#1c1c1c
    hi TelescopePromptBorder guifg=#2c2c2c guibg=#2c2c2c
    hi TelescopePromptNormal guifg=#ffffff guibg=#2c2c2c
    hi TelescopePromptTitle guifg=#ff8888 guibg=#2c2c2c gui=bold
]])

-- Noice
vim.cmd([[
    hi NoiceCmdlineIcon guifg=#ff8888
    hi NoiceCmdlinePopup guibg=#121212 guifg=#ffffff
    hi NoiceCmdlinePopupBorder guibg=#121212 guifg=#121212
    hi NoiceCmdlinePopupTitle guifg=#ff8888
]])

-- Background colors
--[[vim.cmd([[
    hi Normal guibg=#0c0c1c
    hi NormalNC guibg=#0c0c1c
    hi NeoTreeNormalNC guibg=#101020
    hi NeoTreeNormal guibg=#101020
    hi CursorLine guibg=#1c1c2c
)]]
--
--[[
hi Normal guibg=#010101
hi NormalNC guibg=#050505
]]
--[[
    hi @lsp.type.function guifg=#eeee88
    hi @lsp.type.struct guifg=#2eafd9
    hi @lsp.type.class guifg=#2eafd9
    hi @lsp.type.interface guifg=#ff5555
]]
--

-- Fix Darcula theme (disable when not using darcula)
--[[vim.cmd([[
    hi Normal guibg=#1a1a1f
    hi FoldColumn guifg=#555555
    hi WinSeparator guifg=#333333
    hi LineNr guifg=#555555
    hi NonText guifg=#1b1b1b
    hi NeoTreeNormal guibg=#2a2a2d
    hi NeoTreeNormalNC guibg=#2a2a2d
    hi NeoTreeDirectoryIcon guifg=#666666
    hi NeoTreeDirectoryName guifg=#dddddd
    hi NeoTreeMessage guifg=#777777
    hi NeoTreeCursorLine guibg=#2f426e
    hi CursorLine guibg=#252529
    ]]
--
