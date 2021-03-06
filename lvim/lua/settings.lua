local U = require("utilities")
local Settings = {}

-- Determine the path to the LLDB library based on:
-- - Envrironment variables (`LIBLLDB`)
-- - Operationg system
-- 	- If on OSX, the LLDB in Xcode-beta.app will be used if it exists.
local function libLLDBSetup()
	local succeded, libLLDB = pcall(os.getenv, "LIBLLDB")
	if succeded and libLLDB ~= nil then
		return libLLDB
	end

	local os = jit.os

	if os == "OSX" then
		local libLLDBPath = "/Applications/Xcode.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB"
		local libLLDBBetaPath = "/Applications/Xcode-beta.app/Contents/SharedFrameworks/LLDB.framework/Versions/A/LLDB"

		if vim.fn.filereadable(libLLDBPath) then
			return libLLDBPath
		elseif vim.fn.filereadable(libLLDBBetaPath) then
			return libLLDBBetaPath
		end
	elseif os == "Linux" and vim.fn.filereadable("usr/lib/liblldb.so") then
		return "/usr/lib/liblldb.so"
	end
end

-- The LLDB library to use for debugging with nvim-dap.
Settings.libLLDB = libLLDBSetup()

function Settings.setOptions()
	local o = vim.o
	-- local au = require("au")

	vim.filetype.add({
		extension = {
			scm = "query",
		},
	})

	vim.filetype.add({
		extension = {
			geojson = "json",
		},
	})

	o.expandtab = false
	o.timeoutlen = 100
	o.tabstop = 4
	o.cursorline = true
	o.relativenumber = true
	o.shiftwidth = 4
	o.termguicolors = true
	o.splitbelow = true
	o.splitright = true
	o.hidden = true
	o.backspace = "indent,eol,start"
	vim.wo.number = true
	o.updatetime = 200
	o.encoding = "utf8"
	o.cmdheight = 1
	o.winfixwidth = true
	o.linespace = 20

	vim.g.do_filetype_lua = 1
	vim.g.did_load_filetypes = 0

end

function Settings.setKeymaps()
	vim.cmd [[inoremap <esc>   <NOP>]]
	vim.cmd [[inoremap <Left>  <NOP>]]
	vim.cmd [[inoremap <Right> <NOP>]]
	vim.cmd [[inoremap <Up>    <NOP>]]
	vim.cmd [[inoremap <Down>  <NOP>]]
	vim.cmd [[nnoremap <Left>  <NOP>]]
	vim.cmd [[nnoremap <Right> <NOP>]]
	vim.cmd [[nnoremap <Up>    <NOP>]]
	vim.cmd [[nnoremap <Down>  <NOP>]]
	vim.cmd [[vnoremap <Down>  <NOP>]]
	vim.cmd [[vnoremap <Left>  <NOP>]]
	vim.cmd [[vnoremap <Right> <NOP>]]
	vim.cmd [[vnoremap <Up>    <NOP>]]
	vim.cmd [[vnoremap <esc>   <NOP>]]
	vim.cmd [[nnoremap <space><cr> :nohlsearch<cr>]]
	vim.cmd [[au VimEnter * highlight Visual guifg=cyan guibg=DarkSlateGray4 gui=none]]
	vim.cmd [[au VimEnter * highlight Search guibg=green ]]
	-- vim.cmd [[au VimEnter * highlight LineNr guifg=cyan3]]
	-- vim.cmd [[au VimEnter * highlight CursorLine guibg=DarkSlateBlue]]
	vim.cmd [[set shell=zsh]]
	-- vim.cmd [[autocmd VimEnter,WinEnter * match Cursor /\%#./]]
	-- " These create newlines like o and O but stay in normal mode

	vim.cmd [[
  function! s:BlankUp() abort
	let cmd = 'put!=repeat(nr2char(10), v:count1)|silent '']+'
	return cmd
  endfunction

  	nmap ]<space> :<C-U>exe <SID>BlankUp()<CR>
	]]

	vim.cmd [[
  function! s:BlankDown() abort
	let cmd = 'put =repeat(nr2char(10), v:count1)|silent ''[-'
	return cmd
  endfunction

  	nmap [<space> :<C-U>exe <SID>BlankDown()<CR>
	]]

	-- vim.cmd [[nnoremap <silent> <Plug>(unimpaired-blank-up)   :<C-U>exe <SID>BlankUp()<CR>]]
	-- vim.cmd [[nnoremap <silent> <Plug>(unimpaired-blank-down) :<C-U>exe <SID>BlankDown()<CR> ]]
	-- vim.cmd [[nnoremap <silent> <Plug>unimpairedBlankUp   :<C-U>exe <SID>BlankUp()<CR>]]
	-- vim.cmd [[nnoremap <silent> <Plug>unimpairedBlankDown :<C-U>exe <SID>BlankDown()<CR>]]
	-- vim.keymap.set('i', '<C-,>', '<Plug>(copilot-next)')
	-- vim.keymap.set('i', '<C-.>', '<Plug>(copilot-previous)')

	vim.cmd [[highlight CopilotSuggestion guifg=#555555 ctermfg=8]]
	-- vim.cmd [[nnoremap <Leader>o o<Esc>]]
	-- vim.cmd [[nnoremap <Leader>O O<Esc>]]

	-- vim.cmd [[nnoremap <Leader>o o<Esc>0"_D]]
	-- vim.cmd [[nnoremap <Leader>O O<Esc>0"_D]]

	-- vim.cmd [[au DiffAdd * highlight LineNr guifg=cyan3]]
	-- vim.cmd [[au DiffChange * highlight LineNr guifg=cyan3]]
	-- vim.cmd [[au DiffDelete * highlight LineNr guifg=red]]
	-- vim.cmd [[au DiffText * highlight LineNr guifg=cyan3]]

	-- Open a terminal in the current buffer.
	vim.cmd([[cabbrev t terminal]])

	vim.cmd([[cabbrev re resize]])
	vim.cmd([[cabbrev vre vertical resize]])

	-- Shortcut for opening new tab.
	vim.cmd([[cabbrev tt tabe]])

	-- Close the current terminal with <Esc>.
	U.map("t", "<Esc>", "<C-\\><C-n>", { noremap = true })

	-- Split navigation.
	U.map("n", "<C-J>", "<C-W><C-J>", { noremap = true })
	U.map("n", "<C-K>", "<C-W><C-K>", { noremap = true })
	U.map("n", "<C-L>", "<C-W><C-L>", { noremap = true })
	U.map("n", "<C-H>", "<C-W><C-H>", { noremap = true })
end

return Settings
