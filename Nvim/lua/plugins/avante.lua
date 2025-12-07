return {
	"yetone/avante.nvim",
	-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
	-- ⚠️ must add this setting! ! !
	build = vim.fn.has("win32") ~= 0 and "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false"
		or "make",
	version = false, -- Never set this value to "*"! Never!
	lazy = true, -- Do not automatically load
	-- event = "VeryLazy",
	cmd = {
		"AvanteAsk",
	},
	opts = {
		-- add any opts here
		-- this file can contain specific instructions for your project
		instructions_file = "avante.md",
		-- provider = "copilot",
		provider = "litellm",
		providers = {
			["litellm"] = {
				__inherited_from = "openai",
				endpoint = "https://litellm.sph-prod.ethz.ch/v1",
				model = "anthropic/claude-sonnet-4-5",
				api_key_name = "AVANTE_LITELLM_API_KEY",
				timeout = 30000, -- Timeout in milliseconds
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 20480,
				},
			},
			copilot = {
				timeout = 30000, -- Timeout in milliseconds
				extra_request_body = {
					temperature = 0.75,
					max_tokens = 20480,
				},
			},
		},
		behaviour = {
			-- Fix bug of auto apply suggestions #2750
			auto_approve_tool_permissions = false,
			-- auto_apply_diff_after_generation = false,
		},
	},
	dependencies = {
		"nvim-lua/plenary.nvim",
		"MunifTanjim/nui.nvim",
		--- The below dependencies are optional,
		"nvim-mini/mini.pick", -- for file_selector provider mini.pick
		"nvim-telescope/telescope.nvim", -- for file_selector provider telescope
		"hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
		"ibhagwan/fzf-lua", -- for file_selector provider fzf
		"stevearc/dressing.nvim", -- for input provider dressing
		"folke/snacks.nvim", -- for input provider snacks
		"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
		{
			"zbirenbaum/copilot.lua", -- for providers='copilot'
			opts = {
				-- logger = {
				-- 	file = vim.fn.stdpath("log") .. "/copilot-lua.log",
				-- 	file_log_level = vim.log.levels.DEBUG,
				-- 	print_log_level = vim.log.levels.INFO,
				-- 	trace_lsp = "verbose", -- off, messages, verbose
				-- 	trace_lsp_progress = true, -- Log LSP progress events
				-- 	log_lsp_messages = true, -- Log LSP messages
				-- },
			},
		},
		{
			-- support for image pasting
			"HakonHarnes/img-clip.nvim",
			event = "VeryLazy",
			opts = {
				-- recommended settings
				default = {
					embed_image_as_base64 = false,
					prompt_for_file_name = false,
					drag_and_drop = {
						insert_mode = true,
					},
					-- required for Windows users
					use_absolute_path = true,
				},
			},
		},
		{
			-- Make sure to set this up properly if you have lazy=true
			"MeanderingProgrammer/render-markdown.nvim",
			opts = {
				file_types = { "markdown", "Avante" },
			},
			ft = { "markdown", "Avante" },
		},
	},
}
