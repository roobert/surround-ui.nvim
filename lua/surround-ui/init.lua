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

	local prefix = "<leader>" .. config.options.root_key
	local mappings = {
		{ prefix, group = "Surround" },
	}

	-- around mappings
	local around = { prefix .. "a", group = "around" }
	for char, desc in pairs(all_targets) do
		local around_targets = { prefix .. "a" .. char, desc = desc }
		for ichar, target in pairs(abbreviated_and_grammar_targets) do
			table.insert(around_targets, {
				prefix .. "a" .. char .. ichar,
				"<CMD>call feedkeys('ysa"
					.. (char == "'" and "''" or char)
					.. (ichar == "'" and "''" or ichar)
					.. "')<CR>",
				desc = "ysa" .. char .. ichar .. target,
			})
		end
		table.insert(around, around_targets)
	end
	table.insert(mappings, around)

	-- inner mappings
	local inner = { prefix .. "i", group = "inner" }
	for char, desc in pairs(all_targets) do
		local inner_targets = { prefix .. "i" .. char, desc = desc }
		for ichar, target in pairs(all_targets) do
			table.insert(inner_targets, {
				prefix .. "i" .. char .. ichar,
				"<CMD>call feedkeys('ysi"
					.. (char == "'" and "''" or char)
					.. (ichar == "'" and "''" or ichar)
					.. "')<CR>",
				desc = "ysi" .. char .. ichar .. target,
			})
		end
		table.insert(inner, inner_targets)
	end
	table.insert(mappings, inner)

	-- change mappings
	local change = { prefix .. "c", group = "change" }
	for char, desc in pairs(all_targets) do
		local change_targets = { prefix .. "c" .. char, desc = desc }
		for ichar, target in pairs(all_targets) do
			table.insert(change_targets, {
				prefix .. "c" .. char .. ichar,
				"<CMD>call feedkeys('cs"
					.. (char == "'" and "''" or char)
					.. (ichar == "'" and "''" or ichar)
					.. "')<CR>",
				desc = "cs" .. char .. ichar .. target,
			})
		end
		table.insert(change, change_targets)
	end
	table.insert(mappings, change)

	-- delete mappings
	local delete = { prefix .. "d", group = "delete" }
	for char, target in pairs(all_targets) do
		table.insert(delete, {
			prefix .. "d" .. char,
			"<CMD>call feedkeys('ds" .. (char == "'" and "''" or char) .. "')<CR>",
			desc = "ds" .. char .. target,
		})
	end
	table.insert(mappings, delete)

	-- line mappings
	local line = { prefix .. "s", group = "[s] line" }
	for char, target in pairs(all_targets) do
		table.insert(line, {
			prefix .. "s" .. char,
			"<CMD>call feedkeys('yss" .. (char == "'" and "''" or char) .. "')<CR>",
			desc = "yss" .. char .. target,
		})
	end
	table.insert(mappings, line)

	require("which-key").add(mappings)
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
