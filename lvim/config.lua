lvim.builtin.nvimtree.setup.view.preserve_window_proportions = true
-- lvim.builtin.nvimtree.setup.actions.open_file.resize_window = true
lvim.builtin.terminal.direction = "horizontal"
-- vim.g.copilot_no_tab_map = true
-- vim.api.nvim_set_keymap("i", "<C-J>", 'copilot#Accept("<CR>")', { silent = true, expr = true })

lvim.builtin.cmp.experimental.ghost_text = false
require("nvim-treesitter.configs").setup {
	-- autopairs = { enable = true },
	rainbow = {
		enable = true,
		extended_mode = true,
		max_file_lines = nil
	}
}

lvim.builtin.treesitter.rainbow.enable = true
-- local cmp = require("cmp")
-- lvim.builtin.cmp.mapping = {
-- 	["<Tab>"] = cmp.mapping(function(fallback)
-- 		local copilot_keys = vim.fn["copilot#Accept"]("")
-- 		if copilot_keys ~= "" then
-- 			vim.api.nvim_feedkeys(copilot_keys, "i", false)
-- 		elseif cmp.visible() then
-- 			cmp.select_next_item()
-- 			-- elseif luasnip.expandable() then
-- 			-- 	luasnip.expand()
-- 			-- elseif luasnip.expand_or_jumpable() then
-- 			-- 	luasnip.expand_or_jump()
-- 			-- elseif check_backspace() then
-- 			-- 	fallback()
-- 		else
-- 			fallback()
-- 		end
-- 	end, {
-- 		"i",
-- 		"s",
-- 	}),
-- }

local settings = require("settings")
settings.setOptions()
settings.setKeymaps()

-- lvim.builtin.dap = {
-- 	active = true,
-- 	on_config_done = nil,
-- 	breakpoint = {
-- 		text = "",
-- 		texthl = "lspdiagnosticssignerror",
-- 		linehl = "",
-- 		numhl = "",
-- 	},
-- 	breakpoint_rejected = {
-- 		text = "",
-- 		texthl = "lspdiagnosticssignhint",
-- 		linehl = "",
-- 		numhl = "",
-- 	},
-- 	stopped = {
-- 		text = "",
-- 		texthl = "lspdiagnosticssigninformation",
-- 		linehl = "diagnosticunderlineinfo",
-- 		numhl = "lspdiagnosticssigninformation",
-- 	},
-- }

-- local dap = require "dap"
-- dap.set_log_level('TRACE')

-- if lvim.use_icons then
-- 	vim.fn.sign_define("DapBreakpoint", lvim.builtin.dap.breakpoint)
-- 	vim.fn.sign_define("DapBreakpointRejected", lvim.builtin.dap.breakpoint_rejected)
-- 	vim.fn.sign_define("DapStopped", lvim.builtin.dap.stopped)
-- end


-- lvim.builtin.which_key.mappings["d"] = {
-- 	name = "Debug",
-- 	t = { "<cmd>lua require'dap'.toggle_breakpoint()<cr>", "Toggle Breakpoint" },
-- 	b = { "<cmd>lua require'dap'.step_back()<cr>", "Step Back" },
-- 	c = { "<cmd>lua require'dap'.continue()<cr>", "Continue" },
-- 	C = { "<cmd>lua require'dap'.run_to_cursor()<cr>", "Run To Cursor" },
-- 	d = { "<cmd>lua require'dap'.disconnect()<cr>", "Disconnect" },
-- 	g = { "<cmd>lua require'dap'.session()<cr>", "Get Session" },
-- 	i = { "<cmd>lua require'dap'.step_into()<cr>", "Step Into" },
-- 	o = { "<cmd>lua require'dap'.step_over()<cr>", "Step Over" },
-- 	u = { "<cmd>lua require'dap'.step_out()<cr>", "Step Out" },
-- 	p = { "<cmd>lua require'dap'.pause()<cr>", "Pause" },
-- 	r = { "<cmd>lua require'dap'.repl.toggle()<cr>", "Toggle Repl" },
-- 	s = { "<cmd>lua require'dap'.continue()<cr>", "Start" },
-- 	q = { "<cmd>lua require'dap'.close()<cr>", "Quit" },
-- }

-- if lvim.builtin.dap.on_config_done then
-- 	lvim.builtin.dap.on_config_done(dap)
-- end

-- local libLLDB = require("settings").libLLDB

-- local cmd_codelldb = "/Users/nshv/.vscode/extensions/vadimcn.vscode-lldb-1.7.0/adapter/codelldb"

-- dap.adapters.codelldb_swift = function(on_adapter)

-- 	vim.cmd_codelldb [[!swift build]]

-- 	-- This asks the system for a free port
-- 	local tcp = vim.loop.new_tcp()
-- 	tcp:bind("127.0.0.1", 0)
-- 	local port = tcp:getsockname().port
-- 	tcp:shutdown()
-- 	tcp:close()

-- 	-- Start codelldb with the port
-- 	local stdout = vim.loop.new_pipe(false)
-- 	local stderr = vim.loop.new_pipe(false)
-- 	local opts = {
-- 		stdio = { nil, stdout, stderr },
-- 		args = { "--liblldb", libLLDB, "--port", tostring(port) }
-- 	}
-- 	local handle
-- 	local pid_or_err
-- 	handle, pid_or_err = vim.loop.spawn(
-- 		cmd_codelldb,
-- 		opts,
-- 		function(code)
-- 			stdout:close()
-- 			stderr:close()
-- 			handle:close()
-- 			if code ~= 0 then
-- 				print("codelldb exited with code", code)
-- 			end
-- 		end
-- 	)
-- 	if not handle then
-- 		vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
-- 		stdout:close()
-- 		stderr:close()
-- 		return
-- 	end
-- 	vim.notify("codelldb started. pid=" .. pid_or_err)
-- 	stderr:read_start(
-- 		function(err, chunk)
-- 			assert(not err, err)
-- 			if chunk then
-- 				vim.schedule(
-- 					function()
-- 						require("dap.repl").append(chunk)
-- 					end
-- 				)
-- 			end
-- 		end
-- 	)
-- 	local adapter = {
-- 		type = "server",
-- 		host = "127.0.0.1",
-- 		port = port
-- 	}
-- 	-- 💀
-- 	-- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
-- 	-- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
-- 	vim.defer_fn(
-- 		function()
-- 			on_adapter(adapter)
-- 		end,
-- 		800
-- 	)
-- end

-- dap.adapters.codelldb_rust = function(on_adapter)

-- 	-- This asks the system for a free port
-- 	local tcp = vim.loop.new_tcp()
-- 	tcp:bind("127.0.0.1", 0)
-- 	local port = tcp:getsockname().port
-- 	tcp:shutdown()
-- 	tcp:close()

-- 	-- Start codelldb with the port
-- 	local stdout = vim.loop.new_pipe(false)
-- 	local stderr = vim.loop.new_pipe(false)
-- 	local opts = {
-- 		stdio = { nil, stdout, stderr },
-- 		args = { "--liblldb", libLLDB, "--port", tostring(port) }
-- 	}
-- 	local handle
-- 	local pid_or_err
-- 	handle, pid_or_err = vim.loop.spawn(
-- 		cmd_codelldb,
-- 		opts,
-- 		function(code)
-- 			stdout:close()
-- 			stderr:close()
-- 			handle:close()
-- 			if code ~= 0 then
-- 				print("codelldb exited with code", code)
-- 			end
-- 		end
-- 	)
-- 	if not handle then
-- 		vim.notify("Error running codelldb: " .. tostring(pid_or_err), vim.log.levels.ERROR)
-- 		stdout:close()
-- 		stderr:close()
-- 		return
-- 	end
-- 	vim.notify("codelldb started. pid=" .. pid_or_err)
-- 	stderr:read_start(
-- 		function(err, chunk)
-- 			assert(not err, err)
-- 			if chunk then
-- 				vim.schedule(
-- 					function()
-- 						require("dap.repl").append(chunk)
-- 					end
-- 				)
-- 			end
-- 		end
-- 	)
-- 	local adapter = {
-- 		type = "server",
-- 		host = "127.0.0.1",
-- 		port = port
-- 	}
-- 	-- 💀
-- 	-- Wait for codelldb to get ready and start listening before telling nvim-dap to connect
-- 	-- If you get connect errors, try to increase 500 to a higher value, or check the stderr (Open the REPL)
-- 	vim.defer_fn(
-- 		function()
-- 			on_adapter(adapter)
-- 		end,
-- 		800
-- 	)
-- end

-- dap.configurations.swift = {
-- 	{
-- 		type = "codelldb_swift",
-- 		request = "launch",
-- 		name = "DEBUG",
-- 		program = function()
-- 			return "${workspaceFolder}/.build/debug/" .. vim.fn.substitute(vim.fn.getcwd(), '^.*/', '', '')
-- 		end,
-- 		cwd = "${workspaceFolder}",
-- 		liblldb = libLLDB,
-- 		stopOnEntry = false,
-- 	},
-- }

-- dap.configurations.rust = {
-- 	{
-- 		type = "codelldb_rust",
-- 		request = "launch",
-- 		name = "DEBUG",
-- 		program = function()
-- 			return "${workspaceFolder}/target/debug/" .. vim.fn.substitute(vim.fn.getcwd(), '^.*/', '', '')
-- 		end,
-- 		cwd = "${workspaceFolder}",
-- 		liblldb = libLLDB,
-- 		stopOnEntry = false,
-- 	},
-- }

require("rust-tools").setup {
	tools = {
		on_initialized = function()
			vim.cmd [[
            autocmd BufEnter,CursorHold,InsertLeave,BufWritePost *.rs silent! lua vim.lsp.codelens.refresh()
          ]]
		end,
		autoSetHints = true,
		hover_with_actions = true,
		runnables = {
			use_telescope = true,
		},
	},
	server = {
		-- on_attach = function()
		-- 	vim.cmd [[SymbolsOutlineOpen]]
		-- end,
		on_init = require("lvim.lsp").common_on_init,
		settings = {
			["rust-analyzer"] = {
				lens = {
					enable = true,
				},
				checkOnSave = {
					command = "clippy",
				},
			},
		},
	},
}

-- local rust_tools_opts = {
-- 	autostart = true,
-- 	dap = {
-- 		adapter = require('rust-tools.dap').get_codelldb_adapter(
-- 			cmd_codelldb, libLLDB)
-- 	}
-- }

-- require("rust-tools").setup({
-- 	dap = {
-- 		adapter = require('rust-tools.dap').get_codelldb_adapter(
-- 			cmd_codelldb, libLLDB)
-- 	},
-- 	tools = {
-- 		autoSetHints = true,
-- 		hover_with_actions = true,
-- 		runnables = {
-- 			use_telescope = true,
-- 		},
-- 	},
-- 	server = {
-- 		cmd = { vim.fn.stdpath "data" .. "/lsp_servers/rust/rust-analyzer" },
-- 		on_attach = require("lvim.lsp").common_on_attach,
-- 		on_init = require("lvim.lsp").common_on_init,
-- 	},
-- })

-- dap.defaults.codelldb.terminal_win_cmd = "split new"

--------------------------------------------------

lvim.log.level = "warn"
lvim.format_on_save = false
-- lvim.colorscheme = "tokyonight"
lvim.colorscheme = "onedark"
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
lvim.builtin.which_key.mappings["m"] = {
	"<cmd>SymbolsOutline<CR>",
	"Symbols outline"
}

lvim.builtin.which_key.mappings["r"] = {
	name = "Rust tools",
	i = { "<cmd>RustToggleInlayHints<Cr>", "RustToggleInlayHints" },
	r = { "<cmd>RustRunnables<Cr>", "RustRunnables" },
	M = { "<cmd>RustExpandMacro<Cr>", "RustExpandMacro" },
	c = { "<cmd>RustOpenCargo<Cr>", "RustOpenCargo" },
	p = { "<cmd>RustParentModule<Cr>", "RustParentModule" },
	j = { "<cmd>RustJoinLines<Cr>", "RustJoinLines" },
	h = { "<cmd>RustHoverActions<Cr>", "RustHoverActions" },
	H = { "<cmd>RustHoverRange<Cr>", "RustHoverRange" },
	m = {
		name = "Move",
		u = { "<cmd>RustMoveItemUp<Cr>", "RustMoveItemUp" },
		d = { "<cmd>RustMoveItemDown<Cr>", "RustMoveItemDown" },
	},
	s = { "<cmd>RustStartStandaloneServerForBuffer<Cr>", "Start server for buffer" },
	d = { "<cmd>RustDebuggables<Cr>", "RustDebuggables" },
	g = { "<cmd>RustViewCrateGraph<Cr>", "RustViewCrateGraph" },
	R = { "<cmd>RustReloadWorkspace<Cr>", "RustReloadWorkspace" },
	S = { "<cmd>RustSSR<Cr>", "RustSSR" },
	D = { "<cmd>RustOpenExternalDocs<Cr>", "RustOpenExternalDocs" }
}

lvim.builtin.which_key.mappings["-"] = {
	name = "Dash",
	w = { "<cmd>DashWord<Cr>", "DashWord" },
	f = { "<cmd>Dash<Cr>", "Dash" }
}

lvim.builtin.which_key.mappings["."] = {
	"<cmd>only<CR>",
	"Only"
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

require('onedark').setup {
	-- Main options --
	style = 'darker', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
	transparent = true, -- Show/hide background
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

lvim.builtin.terminal.open_mapping = [[<c-\>]]
-- After changing plugin config exit and reopen LunarVim, Run :PackerInstall :PackerCompile
-- local dashboard_custom = require('dashboard_custom')
-- lvim.builtin.alpha.dashboard_custom = { config = {}, section = dashboard_custom.get_sections() }
-- lvim.builtin.alpha.active = false
-- lvim.builtin.alpha.mode = "dashboard"
lvim.builtin.notify.active = true
lvim.builtin.terminal.active = true
lvim.builtin.nvimtree.setup.view.side = "left"
lvim.builtin.nvimtree.setup.view.relativenumber = true
lvim.builtin.nvimtree.setup.view.auto_resize = true
lvim.builtin.nvimtree.setup.view.width = 40
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
vim.list_extend(lvim.lsp.automatic_configuration.skipped_servers, { "solc", "rust_analyzer" })
nvim_lsp['solc'].setup {
	autostart = true,
	cmd = { "/opt/homebrew/bin/solc", "--lsp" },
	filetypes = { "solidity" },
}

-- nvim_lsp['rust_analyzer'].setup {
-- 	autostart = true,
-- 	-- cmd = { "/Users/nshv/Repos/rust-analyzer/target/release/rust-analyzer"},
-- 	filetypes = { "rs", "rust" },
-- }

local formatters = require "lvim.lsp.null-ls.formatters"
formatters.setup {
	{
		command = "swiftformat",
		filetypes = { "swift" },
	},
}

-- Additional Plugins
lvim.plugins = {
	{ "gelguy/wilder.nvim" },
	{ "navarasu/onedark.nvim" },
	{ "nixprime/cpsm" },
	{ "romgrk/fzy-lua-native" },
	{ "p00f/nvim-ts-rainbow" },
	{ "simrat39/symbols-outline.nvim" },
	{ "udalov/kotlin-vim" },
	{ "rmagatti/auto-session" },
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
	-- {
	-- 	'tzachar/cmp-tabnine',
	-- 	config = function()
	-- 		local tabnine = require "cmp_tabnine.config"
	-- 		tabnine:setup {
	-- 			max_lines = 1000,
	-- 			max_num_results = 20,
	-- 			sort = true
	-- 		}
	-- 	end,

	-- 	run = "./install.sh",
	-- 	requires = "hrsh7th/nvim-cmp"
	-- },
	-- {
	-- 	"Pocco81/dap-buddy.nvim",
	-- 	branch = "dev",
	-- },
	-- {
	-- 	"rcarriga/nvim-dap-ui",
	-- 	requires = { "dap" }
	-- },
	{
		"simrat39/rust-tools.nvim"
	},
	{
		"mrjones2014/dash.nvim",
		run = 'make install'
	},
	{
		"pechorin/any-jump.vim"
	},
	{
		"dense-analysis/ale",
		enable = false
	},
	-- {
	-- 	"github/copilot.vim"
	-- },
	{ "zbirenbaum/copilot.lua",
		event = { "VimEnter" },
		config = function()
			vim.defer_fn(function()
				require("copilot").setup {
					plugin_manager_path = get_runtime_dir() .. "/site/pack/packer",
				}
			end, 100)
		end,
	},

	{ "zbirenbaum/copilot-cmp",
		after = { "copilot.lua", "nvim-cmp", "dense-analysis/ale" },
	},
	{
		"arkav/lualine-lsp-progress",
	}
	-- Can not be placed into the config method of the plugins.
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	event = { "VimEnter" },
	-- 	config = function()
	-- 		vim.defer_fn(function()
	-- 			require("copilot").setup {
	-- 				cmp = {
	-- 					enabled = true,
	-- 					method = "getCompletionsCycling",
	-- 				},
	-- 				panel = { -- no config options yet
	-- 					enabled = true,
	-- 				},
	-- 				ft_disable = {},
	-- 				plugin_manager_path = vim.fn.stdpath("data") .. "/site/pack/packer",
	-- 				server_opts_overrides = {},
	-- 			}
	-- 		end, 100)
	-- 	end,
	-- },
	-- {
	-- 	"zbirenbaum/copilot-cmp",
	-- 	-- after = 'copilot.lua'
	-- 	module = 'copilot_cmp'
	-- }
}
lvim.builtin.cmp.formatting.source_names["copilot"] = "(Copilot)"
table.insert(lvim.builtin.cmp.sources, 1, { name = "copilot" })

lvim.builtin.lualine.sections.lualine_c = { 'lsp_progress' }

-- require("copilot").setup {
-- 	cmp = {
-- 		enabled = true,
-- 		method = "getCompletionsCycling",
-- 	}
-- }
-- local dapui = require("dapui")

-- dapui.setup({
-- sidebar = {
-- 	elements = {
-- 		{ id = "scopes", size = 0.25 },
-- 		{ id = "breakpoints", size = 0.25 },
-- 		{ id = "stacks", size = 0.25 },
-- 		--{ id = "watches", size = 0.50 },
-- 	},
-- 	size = 70,
-- 	position = "left",
-- },
-- })

-- dap.listeners.after.event_initialized["dapui_config"] = function()
-- 	dapui.open()
-- end
-- dap.listeners.before.event_terminated["dapui_config"] = function()
-- 	dapui.close()
-- end
-- dap.listeners.before.event_exited["dapui_config"] = function()
-- 	dapui.close()
-- end

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

lvim.builtin.project.patterns = { ".git", "_darcs", ".hg", ".bzr", ".svn", "Makefile", "package.json", "Package.swift", ".xcworkspace", ".xcodeproj", "Cargo.toml" }
lvim.builtin.project.show_hidden = true

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
-- require("telescope").load_extension('harpoon')
require('session-lens').setup {
	prompt_title = 'SESSIONS',
}

if string.match(vim.fn.system('uname -a'), 'mini') then
	vim.o.guifont = "JetBrainsMono Nerd Font Mono:h13"
else
	vim.o.guifont = "JetBrainsMono Nerd Font Mono:h12"
end

-- vim.g.neovide_transparency = 0.75
vim.g.neovide_cursor_vfx_mode = "ripple"
vim.g.neovide_remember_window_size = true
vim.g.neovide_remember_window_position = true
-- vim.g.neovide_cursor_antialiasing = true
-- vim.g.neovide_fullscreen = true

if vim.bo.filetype == "swift" then
	require 'swift_env'.attach()
end

vim.cmd [[let g:ale_fixers = {'swift': ['swiftformat']}]]

-- originally authored by @AdamWhittingham

local path_ok, plenary_path = pcall(require, "plenary.path")
if not path_ok then
	return
end

local dashboard = require "alpha.themes.dashboard"
local user_config_path = require("lvim.config"):get_user_config_path()
local cdir = vim.fn.getcwd()
local if_nil = vim.F.if_nil

local function get_extension(fn)
	local match = fn:match "^.+(%..+)$"
	local ext = ""
	if match ~= nil then
		ext = match:sub(2)
	end
	return ext
end

local function icon(fn)
	local nwd = require "nvim-web-devicons"
	local ext = get_extension(fn)
	return nwd.get_icon(fn, ext, { default = true })
end

local function file_button(fn, sc, short_fn)
	short_fn = short_fn or fn
	local ico_txt
	local fb_hl = {}

	if lvim.use_icons then
		local ico, hl = icon(fn)
		table.insert(fb_hl, { hl, 0, 3 })
		ico_txt = ico .. "  "
	else
		ico_txt = ""
	end
	local file_button_el = dashboard.button(sc, ico_txt .. short_fn, "<cmd>e " .. fn .. " <CR>")
	local fn_start = short_fn:match ".*[/\\]"
	if fn_start ~= nil then
		table.insert(fb_hl, { "Comment", #ico_txt - 2, #fn_start + #ico_txt })
	end
	file_button_el.opts.hl = fb_hl
	return file_button_el
end

local default_mru_ignore = { "gitcommit" }

local mru_opts = {
	ignore = function(path, ext)
		return (string.find(path, "COMMIT_EDITMSG")) or (vim.tbl_contains(default_mru_ignore, ext))
	end,
}

--- @param start number
--- @param cwd string optional
--- @param items_number number optional number of items to generate, default = 10
local function mru(start, cwd, items_number, opts)
	opts = opts or mru_opts
	items_number = if_nil(items_number, 10)

	local oldfiles = {}
	for _, v in pairs(vim.v.oldfiles) do
		if #oldfiles == items_number then
			break
		end
		local cwd_cond
		if not cwd then
			cwd_cond = true
		else
			cwd_cond = vim.startswith(v, cwd)
		end
		local ignore = (opts.ignore and opts.ignore(v, get_extension(v))) or false
		if (vim.fn.filereadable(v) == 1) and cwd_cond and not ignore then
			oldfiles[#oldfiles + 1] = v
		end
	end
	local target_width = 35

	local tbl = {}
	for i, fn in ipairs(oldfiles) do
		local short_fn
		if cwd then
			short_fn = vim.fn.fnamemodify(fn, ":.")
		else
			short_fn = vim.fn.fnamemodify(fn, ":~")
		end

		if #short_fn > target_width then
			short_fn = plenary_path.new(short_fn):shorten(1, { -2, -1 })
			if #short_fn > target_width then
				short_fn = plenary_path.new(short_fn):shorten(1, { -1 })
			end
		end

		local shortcut = tostring(i + start - 1)

		local file_button_el = file_button(fn, shortcut, short_fn)
		tbl[i] = file_button_el
	end
	return {
		type = "group",
		val = tbl,
		opts = {},
	}
end

local default_header = {
	type = "text",
	val = {
		[[ ##    ##  ######  ##     ## ##     ##  ]],
		[[ ###   ## ##    ## ##     ## ##     ##  ]],
		[[ ####  ## ##       ##     ## ##     ##  ]],
		[[ ## ## ##  ######  ######### ##     ##  ]],
		[[ ##  ####       ## ##     ##  ##   ##   ]],
		[[ ##   ### ##    ## ##     ##   ## ##    ]],
		[[ ##    ##  ######  ##     ##    ###     ]],
	},
	opts = {
		position = "center",
		hl = "Label",
	},
}

local section_mru = {
	type = "group",
	val = {
		{
			type = "text",
			val = "Recent files",
			opts = {
				hl = "SpecialComment",
				shrink_margin = false,
				position = "center",
			},
		},
		{ type = "padding", val = 1 },
		{
			type = "group",
			val = function()
				return { mru(0, cdir) }
			end,
			opts = { shrink_margin = false },
		},
	},
}

local buttons = {
	type = "group",
	val = {
		dashboard.button("SPC f", "  Find File", ":Telescope find_files<CR>"),
		dashboard.button("SPC n", "  New File", ":ene!<CR>"),
		dashboard.button("SPC P", "  Recent Projects ", ":Telescope projects<CR>"),
		dashboard.button("SPC s r", "  Recently Used Files", ":Telescope oldfiles<CR>"),
		dashboard.button("SPC s t", "  Find Word", ":Telescope live_grep<CR>"),
		dashboard.button("SPC L c", "  Configuration", ":edit " .. user_config_path .. "<CR>"),
	},
	position = "center",
}

lvim.builtin.alpha.dashboard.config = {
	layout = {
		{ type = "padding", val = 5 },
		default_header,
		{ type = "padding", val = 2 },
		section_mru,
		{ type = "padding", val = 2 },
		buttons,
	},
	opts = {
		margin = 5,
		setup = function()
			vim.cmd [[autocmd alpha_temp DirChanged * lua require('alpha').redraw()]]
		end,
	},
}
