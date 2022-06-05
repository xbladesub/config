-- -[[
-- lvim is the global options object
--
-- Linters should be
-- filled in as strings with either
-- a global executable or a path to
-- an executable
-- ]]
-- THESE ARE EXAMPLE CONFIGS FEEL FREE TO CHANGE TO WHATEVER YOU WANT

-- general

-- vim.cmd [[inoremap <esc>   <NOP>]]
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
-- vim.cmd [[vnoremap <esc>   <NOP>]]
vim.cmd [[nnoremap <space><cr> :nohlsearch<cr>]]


lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"
-- to disable icons and use a minimalist setup, uncomment the following
-- lvim.use_icons = false

-- keymappings [view all the defaults by pressing <leader>Lk]
lvim.leader = "space"
-- add your own keymapping
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"
-- nmap('<leader>s', ":lua require('auto-session').SaveSession(require('auto-session').get_root_dir() .. vim.fn.input('SessionName > '))
-- <CR>")
-- unmap a default keymapping
-- lvim.keys.normal_mode["<C-Up>"] = false
-- edit a default keymappin

-- Change Telescope navigation to use j and k for navigation and n and p for history in both input and normal mode.
-- we use protected-mode (pcall) just in case the plugin wasn't loaded yet.
-- local _, actions = pcall(require, "telescope.actions")
-- lvim.builtin.telescope.defaults.mappings = {
--   -- for input mode
--   i = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--     ["<C-n>"] = actions.cycle_history_next,
--     ["<C-p>"] = actions.cycle_history_prev,
--   },
--   -- for normal mode
--   n = {
--     ["<C-j>"] = actions.move_selection_next,
--     ["<C-k>"] = actions.move_selection_previous,
--   },
-- }:

-- Use which-key to add extra bindings with the leader-key prefix
lvim.builtin.which_key.mappings["P"] = { "<cmd>Telescope projects<CR>", "Projects" }
lvim.builtin.which_key.mappings["t"] = {
	name = "+Trouble",
	r = { "<cmd>Trouble lsp_references<cr>", "References" },
	f = { "<cmd>Trouble lsp_definitions<cr>", "Definitions" },
	d = { "<cmd>Trouble document_diagnostics<cr>", "Diagnostics" },
	q = { "<cmd>Trouble quickfix<cr>", "QuickFix" },
	l = { "<cmd>Trouble loclist<cr>", "LocationList" },
	w = { "<cmd>Trouble workspace_diagnostics<cr>", "Wordspace Diagnostics" },
}
lvim.builtin.which_key.mappings["s"].S = {
	"<cmd>lua require('auto-session').SaveSession(require('auto-session').get_root_dir() .. vim.fn.input('SessionName: '))<CR>",
	"Save session"
}

lvim.builtin.which_key.mappings["s"].s = {
	"<cmd>SearchSession<CR>",
	"Search session"
}
lvim.builtin.which_key.mappings["r"] = {
	"<cmd>SymbolsOutline<CR>",
	"Symbols outline"
}
-- Example config in Lua
vim.g.tokyonight_style = "night"
vim.g.tokyonight_italic_functions = false
vim.g.tokyonight_sidebars = { "qf", "vista_kind", "terminal", "packer" }

-- Change the "hint" color to the "orange" color, and make the "error" color bright red
vim.g.tokyonight_colors = { hint = "orange", error = "#ff0000" }
-- lvim.builtin.which_key.mappings["D"] = {
-- 	"<cmd>DiffviewOpen<CR>",
-- 	"Show diff view"
-- }

-- lvim.builtin.which_key.mappings["d"] = {
-- 	"<cmd>DiffviewClose<CR>",
-- 	"Hide diff view"
-- }

-- lvim.builtin.dap.active = true
-- lvim.builtin.which_key.mappings["d"] = {
--   name = "Debug",
--   t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
--   b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
--   c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
--   C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
--   d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
--   g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
--   i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
--   o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
--   u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
--   p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
--   r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
--   s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
--   q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
-- }

-- local dap = require('dap')
-- dap.set_log_level('DEBUG')
-- dap.adapters.lldb = {
--   type = 'executable',
--   command = '/opt/homebrew/Cellar/llvm/13.0.1_1/bin/lldb-vscode', -- adjust as needed, must be absolute path
--   name = 'lldb'
-- }

-- dap.configurations.swift = {
--   {
--     name = 'Launch',
--     type = 'lldb',
--     request = 'launch',
--     program = function()
--       return vim.fn.input('Path to executable: ', vim.fn.getcwd() .. '/', 'file')
--     end,
--     cwd = '${workspaceFolder}',
--     stopOnEntry = false,
--     args = { "xcrun swift build -c release --arch arm64" },

--     -- ??
--     -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
--     --
--     --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
--     --
--     -- Otherwise you might get the following error:
--     --
--     --    Error on launch: Failed to attach to the target process
--     --
--     -- But you should be aware of the implications:
--     -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
--     -- runInTerminal = false,
--   },
-- }

-- lvim.builtin.terminal.execs = { "lazygit", "<leader>gg", "LazyGit", "float" }
lvim.builtin.terminal.open_mapping = [[<c-\>]]
-- lvim.builtin.which_key.presets = {
--   operators = false, -- adds help for operators like d, y, ...
--   motions = false, -- adds help for motions
--   text_objects = false, -- help for text objects triggered after entering an operator
--   windows = true, -- default bindings on <c-w>
--   nav = true, -- misc bindings to work with windows
--   z = true, -- bindings for folds, spelling and others prefixed with z
--   g = true,
-- }
-- TODO: User Config for predefined plugins
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
-- lvim.builtin.nvimtree.show_icons.git = 0

-- if you don't want all the parsers change this to a table of the ones yosru want
lvim.builtin.treesitter.ensure_installed = {
	"bash",
	"c",
	"javascript",
	"json",
	"lua",
	"python",
	"typescript",
	"tsx",
	"css",
	"rust",
	"java",
	"yaml",
	"swift",
	"kotlin"
}

lvim.builtin.treesitter.ignore_install = { "haskell" }
lvim.builtin.treesitter.highlight.enabled = true

-- generic LSP settings

-- ---@usage disable automatic installation of servers
-- lvim.lsp.automatic_servers_installation = false

-- ---configure a server manually. !!Requires `:LvimCacheReset` to take effect!!
-- ---see the full default list `:lua print(vim.inspect(lvim.lsp.automatic_configuration.skipped_servers))`
local nvim_lsp = require 'lspconfig'
-- vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "solc" })
nvim_lsp["clangd"].setup {}
local opts = { autostart = true } -- check the lspconfig documentation for a list of all possible options
-- local opts1 = { autostart = true } -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("sourcekit", opts)
require("lvim.lsp.manager").setup("solidity_ls", opts)
require("lvim.lsp.manager").setup("solc", opts)
require("lvim.lsp.manager").setup("kotlin_language_server", opts)
-- require('lspconfig').solc.setup({
-- 	autostart = true,
-- 	cmd_env = {
-- 		PATH = '/usr/local/bin/'
-- 	}

-- })
-- -- set a formatter, this will override the language server formatting capabilities (if it exists)
local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
	--   { command = "black", filetypes = { "python" } },
	--   { command = "isort", filetypes = { "python" } },
	{
		-- each formatter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
		command = "swiftformat",
		---@usage arguments to pass to the formatter
		-- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
		-- extra_args = { "--print-with", "100" },
		--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
		filetypes = { "swift" },
	},
}

-- -- set additional linters
-- local linters = require "lvim.lsp.null-ls.linters"
-- linters.setup {
--   { command = "flake8", filetypes = { "python" } },
--   {
--     -- each linter accepts a list of options identical to https://github.com/jose-elias-alvarez/null-ls.nvim/blob/main/doc/BUILTINS.md#Configuration
--     command = "shellcheck",
--     ---@usage arguments to pass to the formatter
--     -- these cannot contain whitespaces, options such as `--line-width 80` become either `{'--line-width', '80'}` or `{'--line-width=80'}`
--     extra_args = { "--severity", "warning" },
--   },
--   {
--     command = "codespell",
--     ---@usage specify which filetypes to enable. By default a providers will attach to all the filetypes it supports.
--     filetypes = { "javascript", "python" },
--   },
-- }

-- Additional Plugins
lvim.plugins = {
	{ "navarasu/onedark.nvim" },
	{ "gelguy/wilder.nvim" },
	{ "nixprime/cpsm" },
	{ "romgrk/fzy-lua-native" },
	{ "p00f/nvim-ts-rainbow" },
	{ "simrat39/symbols-outline.nvim" },
	{ "udalov/kotlin-vim" },
	{ "rmagatti/auto-session" },
	{ "ThePrimeagen/harpoon" },
	{ "sindrets/diffview.nvim" },
	{
		"rmagatti/session-lens",
		requires = { 'rmagatti/auto-session', 'nvim-telescope/telescope.nvim' }
	},
	{ "keith/swift.vim" },
	{ "tami5/swift.nvim" },
	{ "lukas-reineke/indent-blankline.nvim" },

	{
		"folke/trouble.nvim",
		cmd = "TroubleToggle",
	},
	{
		'phaazon/hop.nvim',
		branch = 'v1', -- optional but strongly recommended
		config = function()
			-- you can configure Hop the way you like here; see :h hop-config
			require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
		end
	},
	{
		'xbladesub/surround.nvim'
	},
	{
		'folke/tokyonight.nvim'
	},
	{
		'LunarVim/vim-solidity'
	},
	{
		'tzachar/cmp-tabnine',
		config = function()
			local tabnine = require "cmp_tabnine.config"
			tabnine:setup {
				max_lines = 1000,
				max_num_results = 20,
				sort = true
			}
		end,

		run = "./install.sh",
		requires = "hrsh7th/nvim-cmp"
	},
}

require "surround".setup {
	context_offset = 100,
	load_autogroups = false,
	mappings_style = "sandwich",
	map_insert_mode = true,
	quotes = { "'", '"' },
	brackets = { "(", '{', '[' },
	space_on_closing_char = false,
	pairs = {
		nestable = { b = { "(", ")" }, s = { "[", "]" }, B = { "{", "}" }, a = { "<", ">" } },
		linear = { q = { "'", "'" }, t = { "`", "`" }, d = { '"', '"' }
		},
		prefix = "s"
	}
}

require('onedark').setup {
	-- Main options -
	style = 'cool', -- Default theme style. Choose between 'dark', 'darker', 'cool   'deep', 'warm', 'warmer' and 'light'
	transparent = false, -- Show/hide background
	term_colors = true, -- Change terminal color as per the selected theme style
	ending_tildes = false, -- Show the end-of-buffer tildes. By default they are hidden
	cmp_itemkind_reverse = false, -- reverse item kind highlights in cmp menu
	-- toggle theme style ---
	toggle_style_key = '<leader>ts', -- Default keybinding to toggle
	toggle_style_list = { 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer', 'light' }, -- List of styles to toggle between

	-- Change code style ---
	-- Options are italic, bold, underline, none
	-- You can configure multiple style with comma seperated, For e.g., keywords = 'italic,bold'
	code_style = {
		comments = 'none',
		keywords = 'none',
		functions = 'none',
		strings = 'none',
		variables = 'none'
	},

	-- Custom Highlights --
	colors = {}, -- Override default colors
	highlights = {}, -- Override highlight groups

	-- Plugins Config --
	diagnostics = {
		darker = true, -- darker colors for diagnostic
		undercurl = true, -- use undercurl instead of underline for diagnostics
		background = true, -- use background color for virtual text
	},
}

local wilder = require('wilder')
wilder.setup({ modes = { ':', '/', '?' } })

local gradient = {
	'#f4468f', '#fd4a85', '#ff507a', '#ff566f', '#ff5e63',
	'#ff6658', '#ff704e', '#ff7a45', '#ff843d', '#ff9036',
	'#f89b31', '#efa72f', '#e6b32e', '#dcbe30', '#d2c934',
	'#c8d43a', '#bfde43', '#b6e84e', '#aff05b'
}

for i, fg in ipairs(gradient) do
	gradient[i] = wilder.make_hl('WilderGradient' .. i, 'Pmenu', { { a = 1 }, { a = 1 }, { foreground = fg } })
end

local popupmenu_renderer = wilder.popupmenu_renderer(
	wilder.popupmenu_border_theme({
		winblend = 20,
		border = 'rounded',
		empty_message = wilder.popupmenu_empty_message_with_spinner(),
		-- }),
		highlights = {
			gradient = gradient, -- must be set
			-- selected_gradient key can be set to apply gradient highlighting for the selected candidate.
		},
		highlighter = wilder.highlighter_with_gradient({
			wilder.lua_fzy_highlighter(), -- or wilder.lua_fzy_highlighter(),
		}),
		left = {
			' ',
			wilder.popupmenu_devicons(),
			wilder.popupmenu_buffer_flags({
				flags = ' a + ',
				icons = { ['+'] = '', a = '', h = '' },
			}),
		},
		right = {
			' ',
			wilder.popupmenu_scrollbar(),
		},
	})
)

local wildmenu_renderer = wilder.wildmenu_renderer({
	highlighter = wilder.highlighter_with_gradient({
		wilder.lua_fzy_highlighter(), -- or wilder.lua_fzy_highlighter(),
	}),
	separator = ' · ',
	left = { ' ', wilder.wildmenu_spinner(), ' ' },
	right = { ' ', wilder.wildmenu_index() },
})

wilder.set_option('renderer', wilder.renderer_mux({
	[':'] = popupmenu_renderer,
	['/'] = wildmenu_renderer,
	substitute = wildmenu_renderer
}))

vim.opt.expandtab = false
vim.opt.timeoutlen = 100
vim.opt.tabstop = 4
-- local custom_gruvbox = require 'lualine.themes.gruvbox'

-- Change the background of lualine_c section for normal mode
-- custom_gruvbox.normal.c.bg = 'purple'
-- custom_gruvbox.normal.c.fg = 'cyan'

-- require('lualine').setup {
-- 	options = { theme = custom_gruvbox },
-- }
-- vim.highlight.create('Visual', { guifg = cyan, guibg = DarkSlateGray4 }, false)
vim.cmd [[set shell=zsh]]
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 4
lvim.builtin.project.patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Package.swift", ".xcworkspace", ".xcodeproj" }
lvim.builtin.project.show_hidden = true
-- lvim.builtin.lualine.style = "default"

require("nvim-treesitter.configs").setup {
	-- autopairs = { enable = true },
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil
	}
}

require 'swift_env'.setup {
	--- Normal/Visual Mode leader key
	leader = "<leader>",
	--- Format Configuration
	format = {
		-- path to the swiftformat binary.
		cmd = "swiftformat",
		-- command to run formater manually
		ex = "Sfmt",
		-- mapping to run formater manually
		mapping = "eF",
		-- whether to format on write.
		auto = true,
		-- options to be passed when calling swiftformat from the command line
		options = {},
		-- path to config file from root directory
		config_file = ".swiftformat",
		-- create config format config file when it doesn't exists?
		config_create_if_unreadable = true,
		-- the file content to be generated.
		config_default_content = [[]],
	}
}

-- vim.opt.list = true
-- vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
	show_current_context = true,
	show_trailing_blankline_indent = false
	-- show_current_context_start = true,
	-- show_end_of_line = true,
}

vim.g.symbols_outline = {
	highlight_hovered_item = true,
	show_guides = true,
	auto_preview = false,
	position = 'right',
	relative_width = true,
	width = 25,
	auto_close = false,
	show_numbers = false,
	show_relative_numbers = true,
	show_symbol_details = true,
	preview_bg_highlight = 'Pmenu',
	keymaps = { -- These keymaps can be a string or a table for multiple keys
		close = { "<Esc>", "q" },
		goto_location = "<Cr>",
		focus_location = "o",
		hover_symbol = "<C-space>",
		toggle_preview = "K",
		rename_symbol = "r",
		code_actions = "a",
	},
	lsp_blacklist = {},
	symbol_blacklist = {},
	symbols = {
		File = { icon = "", hl = "TSURI" },
		Module = { icon = "", hl = "TSNamespace" },
		Namespace = { icon = "", hl = "TSNamespace" },
		Package = { icon = "", hl = "TSNamespace" },
		Class = { icon = "𝓒", hl = "TSType" },
		Method = { icon = "ƒ", hl = "TSMethod" },
		Property = { icon = "", hl = "TSMethod" },
		Field = { icon = "", hl = "TSField" },
		Constructor = { icon = "", hl = "TSConstructor" },
		Enum = { icon = "ℰ", hl = "TSType" },
		Interface = { icon = "ﰮ", hl = "TSType" },
		Function = { icon = "", hl = "TSFunction" },
		Variable = { icon = "", hl = "TSConstant" },
		Constant = { icon = "", hl = "TSConstant" },
		String = { icon = "𝓐", hl = "TSString" },
		Number = { icon = "#", hl = "TSNumber" },
		Boolean = { icon = "⊨", hl = "TSBoolean" },
		Array = { icon = "", hl = "TSConstant" },
		Object = { icon = "⦿", hl = "TSType" },
		Key = { icon = "🔐", hl = "TSType" },
		Null = { icon = "NULL", hl = "TSType" },
		EnumMember = { icon = "", hl = "TSField" },
		Struct = { icon = "𝓢", hl = "TSType" },
		Event = { icon = "🗲", hl = "TSType" },
		Operator = { icon = "+", hl = "TSOperator" },
		TypeParameter = { icon = "𝙏", hl = "TSParameter" }
	}
}

require('auto-session').setup {
	auto_session_suppress_dirs = { '~/', '~/Repos' },
	log_level = 'info',
	auto_session_enable_last_session = true,
	auto_session_root_dir = "/Users/" .. os.getenv("USER") .. "/.config/lvim_session" .. "/",
	auto_session_enabled = true,
	auto_save_enabled = false,
	auto_restore_enabled = false,
	auto_session_use_git_branch = nil,
	-- the configs below are lua only
	bypass_session_save_file_types = nil
}

require("telescope").load_extension("session-lens")
require("telescope").load_extension('harpoon')
require('session-lens').setup {
	prompt_title = 'SESSIONS',
	-- path_display = { 'shorten' },
	-- theme_conf = { border = false },
	-- previewer = false
}

vim.o.guifont = "JetBrainsMono Nerd Font Mono:h12"

vim.g.neovide_transparency = 0.75
-- vim.g.neovide_cursor_animation_length = 0.03
-- vim.g.neovide_cursor_trail_size = 0.75
vim.g.neovide_cursor_vfx_mode = "ripple"
-- vim.g.neovide_remember_window_size = true
-- vim.g.neovide_remember_window_position = true
-- vim.g.neovide_cursor_antialiasing = true
-- vim.g.neovide_fullscreen = true
lvim.builtin.nvimtree.setup.view.relativenumber = true

if vim.bo.filetype == "swift" then
	require 'swift_env'.attach()
end
-- Autocommands (https://neovim.io/doc/user/autocmd.html)
-- lvim.autocommands.custom_groups = {
--   { "BufWinEnter", "*.lua", "setlocal ts=8 sw=8" },
-- }
vim.cmd [[au VimEnter * highlight Visual guifg=cyan guibg=DarkSlateGray4 gui=none]]
vim.cmd [[au VimEnter * highlight Search guibg=purple ]]
-- vim.cmd [[au VimEnter * highlight CursorLine cterm=underline guifg=none guibg=MediumPurple4 guisp=none]]

-- vim.cmd [[au VimEnter * highlight CursorLine  ctermbg=Yellow   guibg=yellow gui=bold]]
-- vim.cmd [[au VimEnter * highlight StatusLine guibg=purple ]]
vim.cmd [[au VimEnter * highlight LineNr guifg=cyan3]]
