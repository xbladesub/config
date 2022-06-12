lvim.builtin.nvimtree.setup.view.preserve_window_proportions = true
-- lvim.builtin.nvimtree.setup.actions.open_file.resize_window = true

local settings = require("settings")
settings.setOptions()
settings.setKeymaps()

lvim.builtin.dap = {
	active = true,
	on_config_done = nil,
	breakpoint = {
		text = "",
		texthl = "lspdiagnosticssignerror",
		linehl = "",
		numhl = "",
	},
	breakpoint_rejected = {
		text = "",
		texthl = "lspdiagnosticssignhint",
		linehl = "",
		numhl = "",
	},
	stopped = {
		text = "",
		texthl = "lspdiagnosticssigninformation",
		linehl = "diagnosticunderlineinfo",
		numhl = "lspdiagnosticssigninformation",
	},
}

local dap = require "dap"
-- dap.set_log_level('TRACE')

if lvim.use_icons then
	vim.fn.sign_define("DapBreakpoint", lvim.builtin.dap.breakpoint)
	vim.fn.sign_define("DapBreakpointRejected", lvim.builtin.dap.breakpoint_rejected)
	vim.fn.sign_define("DapStopped", lvim.builtin.dap.stopped)
end


lvim.builtin.which_key.mappings["d"] = {
	name = "Debug",
	t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
	b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
	c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
	C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
	d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
	g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
	i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
	o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
	u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
	p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
	r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
	s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
	q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
}

if lvim.builtin.dap.on_config_done then
	lvim.builtin.dap.on_config_done(dap)
end

local libLLDB = require("settings").libLLDB

local cmd = "/Users/nshv/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/adapter/codelldb"

dap.adapters.codelldb_swift = function(on_adapter)

	vim.cmd [[!swift build]]

	-- This asks the system for a free port
	local tcp = vim.loop.new_tcp()
	tcp:bind("127.0.0.1", 0)
	local port = tcp:getsockname().port
	tcp:shutdown()
	tcp:close()

	-- Start codelldb with the port
	local stdout = vim.loop.new_pipe(false)
	local stderr = vim.loop.new_pipe(false)
	local opts = {
		stdio = { nil, stdout, stderr },
		args = { "--liblldb", libLLDB, "--port", tostring(port) }
	}
	local handle
	local pid_or_err
	handle, pid_or_err = vim.loop.spawn(
		cmd,
		opts,
		function(code)
			stdout:close()
			stderr:close()
			handle:close()
			if code ~= 0 then
				print("codelldb exited with code", code)
			end
		end
	)
	if not handle then
		vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
		stdout:close()
		stderr:close()
		return
	end
	vim.notify("codelldb started. pid=" .. pid_or_err)
	stderr:read_start(
		function(err, chunk)
			assert(not err, err)
			if chunk then
				vim.schedule(
					function()
						require("dap.repl").append(chunk)
					end
				)
			end
		end
	)
	local adapter = {
		type = "server",
		host = "127.0.0.1",
		port = port
	}
	-- 💀
	-- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
	-- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
	vim.defer_fn(
		function()
			on_adapter(adapter)
		end,
		800
	)
end

dap.configurations.swift = {
	{
		type = "codelldb_swift",
		request = "launch",
		name = "DEBUG",
		program = function()
			return "${workspaceFolder}/.build/debug/" .. vim.fn.substitute(vim.fn.getcwd(), '^.*/', '', '')
		end,
		cwd = "${workspaceFolder}",
		liblldb = libLLDB,
		stopOnEntry = false,
	},
}

dap.defaults.codelldb.terminal_win_cmd = "split new"

--------------------------------------------------

lvim.log.level = "warn"
lvim.format_on_save = true
lvim.colorscheme = "tokyonight"
lvim.leader = "space"
lvim.keys.normal_mode["<C-s>"] = ":w<cr>"

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
vim.g.tokyonight_italic_variables = false
vim.g.tokyonight_italic_keywords = false
vim.g.tokyonight_italic_comments = false
vim.g.tokyonight_transparent = true
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


lvim.builtin.terminal.open_mapping = [[<c-\>]]
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
lvim.builtin.alpha.active = true
lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.relativenumber = true
lvim.builtin.nvimtree.setup.view.auto_resize = true
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

local nvim_lsp = require 'lspconfig'
nvim_lsp["clangd"].setup {}
local opts = { autostart = true } -- check the lspconfig documentation for a list of all possible options
require("lvim.lsp.manager").setup("solidity_ls", opts)
require("lvim.lsp.manager").setup("kotlin_language_server", opts)
require("lvim.lsp.manager").setup("sourcekit", opts)
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "solc" })
nvim_lsp['solc'].setup {
	autostart = true,
	cmd = { "/Users/nshv/Library/Python/3.8/bin/solc", "--lsp" },
	filetypes = { "solidity" },
}

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
	{
		command = "swiftformat",
		filetypes = { "swift" },
	},
}


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
	{
		"Pocco81/dap-buddy.nvim",
		branch = "dev",
	},
	{
		"rcarriga/nvim-dap-ui",
		requires = { "dap" }
	},
	{
		"theHamsta/nvim-dap-virtual-text",
	}
}

require("nvim-dap-virtual-text").setup({
	enabled = true,
	enabled_commands = true,
	highlight_changed_variables = true,
	highlight_new_as_changed = false,
	show_stop_reason = true,
	commented = false,
})

local dapui = require("dapui")

dapui.setup({
	sidebar = {
		elements = {
			{ id = "scopes", size = 0.25 },
			{ id = "breakpoints", size = 0.25 },
			{ id = "stacks", size = 0.25 },
			--{ id = "watches", size = 0.50 },
		},
		size = 70,
		position = "left",
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open()
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

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

lvim.builtin.project.patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Package.swift", ".xcworkspace", ".xcodeproj" }
lvim.builtin.project.show_hidden = true

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


require("indent_blankline").setup {
	show_current_context = true,
	show_trailing_blankline_indent = false,
	indentLine_char = "▏",
	indent_blankline_buftype_exclude = { "terminal" },
	space_char_blankline = " "
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
}

vim.o.guifont = "JetBrainsMono Nerd Font Mono:h12"

vim.g.neovide_transparency = 0.75
vim.g.neovide_cursor_vfx_mode = "ripple"
-- vim.g.neovide_remember_window_size = true
-- vim.g.neovide_remember_window_position = true
-- vim.g.neovide_cursor_antialiasing = true
-- vim.g.neovide_fullscreen = true

if vim.bo.filetype == "swift" then
	require 'swift_env'.attach()
end
