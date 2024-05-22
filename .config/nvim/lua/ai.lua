local curr_time = math.floor(os.difftime(os.time(), os.time() - (os.time() % 84600)) / 3600)

if curr_time < 9 or curr_time > 15 then
	vim.g.enable_ai = true
end

local function has_value(tab, val)
	for _, value in ipairs(tab) do
		if value == val then
			return true
		end
	end

	return false
end

vim.g.codeium_enabled = true

if
	has_value(
		{ "rust", "javascript", "javascriptreact", "typescript", "typescriptreact", "lua", "python" },
		vim.bo.filetype
	) and vim.g.enable_ai
then
	vim.g.codeium_enabled = true

	require("codeium").setup({})
else
	vim.g.codeium_enabled = false
end
