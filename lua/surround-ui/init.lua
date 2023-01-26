M = {}

local config = require("surround-ui.config")

local function setup_commands()
	local grammar_targets = {
		["["] = "",
		["]"] = "",
		["("] = "",
		[")"] = "",
		["{"] = "",
		["}"] = "",
		["<"] = "",
		[">"] = "",
		["`"] = "",
		["'"] = "",
		['"'] = "",
	}

	local abbreviated_targets = {
		["b"] = " [bracket]",
	}

	local keywords_targets = {
		["w"] = " [word]",
		["W"] = " [WORD]",
		["f"] = " [function]",
		["q"] = " [quote]",
	}

	-- FIXME: probably refactor this stuff..
	local all_targets = {}
	for k, v in pairs(grammar_targets) do
		all_targets[k] = v
	end
	for k, v in pairs(abbreviated_targets) do
		all_targets[k] = v
	end
	for k, v in pairs(keywords_targets) do
		all_targets[k] = v
	end

	local abbreviated_and_grammar_targets = {}
	for k, v in pairs(grammar_targets) do
		abbreviated_and_grammar_targets[k] = v
	end
	for k, v in pairs(abbreviated_targets) do
		abbreviated_and_grammar_targets[k] = v
	end

	local mappings = {
		["<leader>"] = {
			[config.options.root_key] = { name = "Surround" },
		},
	}

	-- around mappings
	mappings["<leader>"][config.options.root_key]["a"] = { name = "around" }
	for char, desc in pairs(all_targets) do
		mappings["<leader>"][config.options.root_key]["a"][char] = { name = desc }
		for ichar, target in pairs(abbreviated_and_grammar_targets) do
			mappings["<leader>"][config.options.root_key]["a"][char][ichar] =
				{ "<CMD>call feedkeys('ysa" .. char .. ichar .. "')<CR>", "ysa" .. char .. ichar .. target }
		end
	end

	-- inner mappings
	mappings["<leader>"][config.options.root_key]["i"] = { name = "inner" }
	for char, desc in pairs(all_targets) do
		mappings["<leader>"][config.options.root_key]["i"][char] = { name = desc }
		for ichar, target in pairs(all_targets) do
			mappings["<leader>"][config.options.root_key]["i"][char][ichar] =
				{ "<CMD>call feedkeys('ysi" .. char .. ichar .. "')<CR>", "ysi" .. char .. ichar .. target }
		end
	end

	-- change mappings
	mappings["<leader>"][config.options.root_key]["c"] = { name = "change" }
	for char, desc in pairs(all_targets) do
		mappings["<leader>"][config.options.root_key]["c"][char] = { name = desc }
		for ichar, target in pairs(all_targets) do
			mappings["<leader>"][config.options.root_key]["c"][char][ichar] =
				{ "<CMD>call feedkeys('cs" .. char .. ichar .. "')<CR>", "cs" .. char .. ichar .. target }
		end
	end

	-- delete mappings
	mappings["<leader>"][config.options.root_key]["d"] = { name = "delete" }
	for char, target in pairs(all_targets) do
		mappings["<leader>"][config.options.root_key]["d"][char] =
			{ "<CMD>call feedkeys('ds" .. char .. "')<CR>", "ds" .. char .. target }
	end

	-- line mappings
	mappings["<leader>"][config.options.root_key]["s"] = { name = "[s] line" }
	for char, target in pairs(all_targets) do
		mappings["<leader>"][config.options.root_key]["s"][char] =
			{ "<CMD>call feedkeys('yss" .. char .. "')<CR>", "yss" .. char .. target }
	end

	require("which-key").register(mappings)
end

M.setup = function(options)
	if options == nil then
		options = {}
	end

	-- merge user supplied options with defaults..
	for k, v in pairs(options) do
		config.options[k] = v
	end

	setup_commands()
end

return M
