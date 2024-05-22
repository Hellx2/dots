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
    hi @keyword.return gui=italic
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
]])
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
