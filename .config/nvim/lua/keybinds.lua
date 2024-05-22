--------------------------
-- Insert mode keybinds --
--------------------------

vim.keymap.set("n", "qa", "<cmd>qa<cr>")
vim.keymap.set("n", "qq", "<cmd>q<cr>")

vim.keymap.set("n", "<C-Del>", "dw", { silent = true, desc = "delete from cursor to end of word" })

vim.keymap.set({ "i", "n" }, "<C-BS>", function()
	-- get cursor position
	local curpos = vim.fn.getcurpos()
	-- get text on current line
	local line = vim.fn.getline(".")

	-- check if the line contains only whitespace
	if line:gsub("%s+", "") == "" then
		-- delete the line
		vim.cmd("delete")

		if not curpos[2] == vim.fn.getcurpos(".")[2] + 1 then
			local _key = vim.api.nvim_replace_termcodes("<up>", true, true, true)
			vim.api.nvim_feedkeys(_key, "n", false)
		end

		-- go to the end of the line
		local _key = vim.api.nvim_replace_termcodes("<end>", true, true, true)
		vim.api.nvim_feedkeys(_key, "n", false)
	else
		-- type a space then delete the previous word, space needed so that it doesn't delete two words when there's only a single character
		local key = vim.api.nvim_replace_termcodes("<space><esc>vbd<esc>i", true, true, true)
		vim.api.nvim_feedkeys(key, "n", false)
		local current_char = vim.fn.getregion(vim.fn.getcurpos(), vim.fn.getcurpos())[1]
		--print('"'..current_char..'"') -- debugging
		if current_char == "" then
			local _key = vim.api.nvim_replace_termcodes("<right>", true, true, true)
			vim.api.nvim_feedkeys(_key, "n", false)
		end
	end
end)

-- TODO: Make this work
vim.keymap.set({ "i", "n" }, "<C-Del>", function()
	--"<esc>vwd<esc>i<right>"
	local curpos = vim.fn.getcurpos()
	local key = vim.api.nvim_replace_termcodes("<esc><right>", true, true, true)
	vim.api.nvim_feedkeys(key, "n", false)

	if curpos[3] == 1 then
		key = vim.api.nvim_replace_termcodes("<left>", true, true, true)
		vim.api.nvim_feedkeys(key, "n", false)
	end

	if
		(not curpos[3] == vim.fn.getcurpos()[3])
		or vim.fn.getregion(vim.fn.getcurpos(), vim.fn.getcurpos())[1]:gsub("%s+", "") == ""
	then
		key = vim.api.nvim_replace_termcodes("<right>", true, true, true)
		vim.api.nvim_feedkeys(key, "n", false)
	end

	key = vim.api.nvim_replace_termcodes("vw<left>d<esc>i", true, true, true)
	vim.api.nvim_feedkeys(key, "n", false)
end)

-- Basic keybinds
vim.keymap.set({ "i", "n" }, "<C-s>", function()
	if vim.bo[vim.api.nvim_win_get_buf(0)].modifiable then
		vim.cmd("w!")
		vim.notify("The current file has been saved.", "info", { title = "Saved" })
	else
		vim.notify("The current file is not modifiable.", "error", { title = "Error" })
	end
end) -- Save

vim.keymap.set({ "n", "i" }, "<C-x>", function()
	require("notify").dismiss()
	require("trouble").close()
	local buf = vim.api.nvim_win_get_buf(0)

	if vim.bo[buf].modifiable then
		vim.cmd("wq!")
	else
		vim.cmd("q!")
	end
end) -- Save (if modifiable) and quit

vim.keymap.set({ "n", "i" }, "<C-q>", function()
	if vim.bo[vim.api.nvim_win_get_buf(0)].modifiable then
		vim.cmd("w")
	end
	vim.cmd("qa!")
end) -- Save (if modifiable) and quit all windows

vim.keymap.set({ "n", "i" }, "<C-S-x>", "<cmd>q!<cr>") -- Forcefully quit without saving
vim.keymap.set({ "n", "i" }, "<C-S-q>", "<cmd>qa!<cr>") -- Forcefully quit all windows without saving

-- Moving windows
vim.keymap.set({ "n", "i" }, "<M-left>", "<cmd>wincmd H<cr>") -- Move window to far left
vim.keymap.set({ "n", "i" }, "<M-right>", "<cmd>wincmd L<cr>") -- Move window to far right
vim.keymap.set({ "n", "i" }, "<M-up>", "<cmd>wincmd K<cr>") -- Move window to top
vim.keymap.set({ "n", "i" }, "<M-down>", "<cmd>wincmd J<cr>") -- Move window to bottom

-- Switching windows
vim.keymap.set({ "n", "i" }, "<C-M-left>", "<cmd>wincmd h<cr>") -- Switch to window to the left
vim.keymap.set({ "n", "i" }, "<C-M-right>", "<cmd>wincmd l<cr>") -- Switch to window to the right
vim.keymap.set({ "n", "i" }, "<C-M-up>", "<cmd>wincmd k<cr>") -- Switch to window above
vim.keymap.set({ "n", "i" }, "<C-M-down>", "<cmd>wincmd j<cr>") -- Switch to window below

-- Copying and pasting
vim.keymap.set({ "i", "n" }, "<C-v>", "<cmd>put<cr>")
vim.keymap.set({ "i", "n" }, "<C-z>", "<cmd>undo<cr>")
vim.keymap.set({ "i", "n" }, "<C-y>", "<cmd>redo<cr>")
vim.keymap.set({ "i" }, "<C-a>", "<esc><C-home>v<C-end>")

vim.keymap.set({ "i", "n" }, "<C-e>", require("actions-preview").code_actions)
vim.keymap.set({ "i", "n" }, "<C-l>", require("ufo").openAllFolds)
vim.keymap.set({ "i", "n" }, "<C-S-l>", require("ufo").closeAllFolds)

-- Telescope
vim.keymap.set({ "i", "n" }, "<C-f>", "<cmd>Telescope current_buffer_fuzzy_find<cr>") -- Find in current buffer
vim.keymap.set({ "i", "n" }, "<C-S-f>", "<cmd>Telescope find_files<cr>") -- Find files
vim.keymap.set({ "i", "n" }, "<C-S-e>", "<cmd>Telescope diagnostics<cr>") -- Show errors and warnings
vim.keymap.set({ "i", "n" }, "<C-t>", "<cmd>Telescope filetypes<cr>") -- Switch filetype
vim.keymap.set({ "i", "n" }, "<C-M-f>", "<cmd>Telescope lsp_references<cr>") -- Find references for variable/function
vim.keymap.set({ "i", "n" }, "<C-h>", "<cmd>Telescope man_pages<cr>") -- Search through help/manual pages
vim.keymap.set({ "i", "n" }, "<C-S-h>", "<cmd>Telescope oldfiles<cr>") -- File history
-- NOTE: Might need to add keybind for `:Telescope treesitter` and `:Telescope vim_options`

--vim.keymap.set({ "i", "n" }, "<C-S-e>", "<cmd>CodeActions all<cr>", { noremap = true })

vim.keymap.set({ "i", "n" }, "<C-w>", "<cmd>bd<cr>")

vim.keymap.set({ "i", "n" }, "<C-S-s>", "<cmd>TroubleToggle<cr>")

--vim.keymap.set({"i"}, { "<C-r>", "<esc>:IncRename " })

vim.schedule(function()
	vim.cmd([[
        nnoremap / <cmd>Telescope current_buffer_fuzzy_find<cr>
    ]])
end)

--------------------------
-- Normal mode keybinds --
--------------------------
local function n(x)
	vim.keymap.set("n", x[1], x[2])
end

n({ "<backspace>", "i<backspace>" })

-- Copying and pasting
n({ "<C-a>", "<C-home>v<C-end>" })

local function t(x)
	vim.cmd.tmap(x)
end

t({ "<C-x>", "<C-\\>" })
t({ "<C-t>", "<C-\\>" })
t({ "<C-q>", "<cmd>qa!<cr>" })

vim.keymap.set("v", "<C-r>", "<cmd>'<,'>SnipRun<cr>", { noremap = true })
vim.keymap.set({ "i", "n" }, "<C-r>", "<cmd>SnipRun<cr>", { noremap = true })

local goto_preview = require("goto-preview")

vim.keymap.set({ "i", "n" }, "<C-g>", goto_preview.goto_preview_definition, { noremap = true })
vim.keymap.set({ "i", "n" }, "<M-g>", goto_preview.goto_preview_type_definition, { noremap = true })
vim.keymap.set({ "i", "n" }, "<M-S-g>", goto_preview.goto_preview_implementation, { noremap = true })
vim.keymap.set({ "i", "n" }, "<C-M-g>", goto_preview.goto_preview_declaration, { noremap = true })
vim.keymap.set({ "i", "n" }, "<C-M-S-g>", goto_preview.goto_preview_references, { noremap = true })
vim.keymap.set({ "i", "n" }, "<C-S-g>", goto_preview.close_all_win, { noremap = true })

--vim.cmd("imap <script><silent><nowait><expr> <S-tab> codeium#Accept()")

vim.keymap.set("i", "<C-tab>", vim.fn["codeium#Accept"], { expr = true, silent = true })

vim.keymap.set("i", "<S-tab>", vim.fn["codeium#Accept"], { expr = true, silent = true })

vim.keymap.set({ "i", "n" }, "<C-d>", function()
	require("neo-tree.command").execute({ action = "show", toggle = true })
end)

vim.keymap.set({ "i", "n" }, "<C-p>", "<cmd>EasyColor<cr>", { noremap = true })
