local ls = require("luasnip")
local s = ls.snippet
local sn = ls.snippet_node
local isn = ls.indent_snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local c = ls.choice_node
local d = ls.dynamic_node
local r = ls.restore_node
local events = require("luasnip.util.events")
local ai = require("luasnip.nodes.absolute_indexer")
local extras = require("luasnip.extras")
local l = extras.lambda
local rep = extras.rep
local p = extras.partial
local m = extras.match
local n = extras.nonempty
local dl = extras.dynamic_lambda
local fmt = require("luasnip.extras.fmt").fmt
local fmta = require("luasnip.extras.fmt").fmta
local conds = require("luasnip.extras.expand_conditions")
local postfix = require("luasnip.extras.postfix").postfix
local types = require("luasnip.util.types")
local parse = require("luasnip.util.parser").parse_snippet
local ms = ls.multi_snippet
local k = require("luasnip.nodes.key_indexer").new_key

return {
	s(
		{ trig = "\\snip", snippetType = "autosnippet" },
		fmt(
			[=[
    s(
     {trig = ><, snippetType = 'autosnippet'},
      ><
     ),]=],
			{ i(1), i(2) },
			{ delimiters = "><" }
		)
	),

	-- Equation environments
	s(
		{ trig = "\\eqq", dscr = "A LaTeX equation environment", snippetType = "autosnippet" },
		fmt( -- The snippet code actually looks like the equation environment it produces.
			[[
      \begin{equation}
          <>
      \end{equation}
    ]],
			-- The insert node is placed in the <> angle brackets
			{ i(1) },
			-- This is where I specify that angle brackets are used as node positions.
			{ delimiters = "<>" }
		)
	),
	s(
		{ trig = "\\align", snippetType = "autosnippet" },
		fmt(
			[[
        \begin{align}
            <>
        \end{align}
      ]],
			{ i(1) },
			{ delimiters = "<>" }
		)
	),
	s(
		{ trig = "\\*align", snippetType = "autosnippet" },
		fmt(
			[[
        \begin{align*}
            <>
        \end{align*}
      ]],
			{ i(1) },
			{ delimiters = "<>" }
		)
	),

	s(
		{ trig = "\\[", dscr = "A LaTeX equation environment", snippetType = "autosnippet" },
		fmt( -- The snippet code actually looks like the equation environment it produces.
			[[
      \[
          <>
      \]
    ]],
			-- The insert node is placed in the <> angle brackets
			{ i(1) },
			-- This is where I specify that angle brackets are used as node positions.
			{ delimiters = "<>" }
		)
	),

	-- Begin environment
	s(
		{ trig = "\\begin", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{<>}
          <>
      \end{<>}
    ]],
			{
				i(1),
				i(2),
				rep(1), -- this node repeats insert node i(1)
			},
			{ delimiters = "<>" }
		)
	),
	s(
		{ trig = "\\def", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{definition}
          <>
      \end{definition}
    ]],
			{
				i(1),
			},
			{ delimiters = "<>" }
		)
	),

	s(
		{ trig = "\\lemma", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{lemma}
          <>
      \end{lemma}
    ]],
			{
				i(1),
			},
			{ delimiters = "<>" }
		)
	),
	s(
		{ trig = "\\theorem", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{theorem}
          <>
      \end{theorem}
    ]],
			{
				i(1),
			},
			{ delimiters = "<>" }
		)
	),
	s(
		{ trig = "\\prop", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{prop}
          <>
      \end{prop}
    ]],
			{
				i(1),
			},
			{ delimiters = "<>" }
		)
	),
	s(
		{ trig = "\\proof", snippetType = "autosnippet" },
		fmta(
			[[
      \begin{proof}
          <>
      \end{proof}
    ]],
			{
				i(1),
			},
			{ delimiters = "<>" }
		)
	),
	-- "Autocorrect" type stuff
	s({ trig = "\\ff", dscr = "Expands 'ff' into '\frac{}{}'", snippetType = "autosnippet" }, {
		t("\\frac{"),
		i(1), -- insert node 1
		t("}{"),
		i(2), -- insert node 2
		t("}"),
	}),

	s({ trig = "<=", snippetType = "autosnippet" }, { t("\\le") }),
	s({ trig = ">=", snippetType = "autosnippet" }, { t("\\ge") }),

	s({ trig = "=>", snippetType = "autosnippet" }, { t("\\Rightarrow") }),
	s({ trig = "=<", snippetType = "autosnippet" }, { t("\\Leftarrow") }),

	s({ trig = "-->", snippetType = "autosnippet" }, { t("\\xrightarrow{"), i(1), t("}") }),
	s({ trig = "--<", snippetType = "autosnippet" }, { t("\\xleftarrow{"), i(1), t("}") }),

	s({ trig = "->", snippetType = "autosnippet" }, { t("\\to") }),
	s({ trig = "-<", snippetType = "autosnippet" }, { t("\\leftarrow") }),

	s({ trig = "\\lr(", snippetType = "autosnippet" }, { t("\\left("), i(1), t("\\right)") }),
	s({ trig = "\\lr[", snippetType = "autosnippet" }, { t("\\left["), i(1), t("\\right]") }),
	s({ trig = "\\lr{", snippetType = "autosnippet" }, { t("\\left\\{"), i(1), t("\\right\\}") }),
	s({ trig = "\\lr<", snippetType = "autosnippet" }, { t("\\left\\langle"), i(1), t("\\right\\rangle") }),

	s({ trig = "...", snippetType = "autosnippet" }, { t("\\ldots") }),
}
