local MoonTex = require("moontex.context")
return {
      s("main",
        fmt([[
%&../.preamble
\endofdump

\usetikzlibrary{{external}}
\tikzset{{external/system call={{pdflatex --shell-escape --fmt=../.preamble --halt-on-error -jobname "\image" "\endofdump\texsource"}}}}
\tikzexternalize[prefix=tikz/]

\title{{{}}}
\author{{Marini Mattia}}
\date{{$ {}^o $ semestre $ {}^o $ anno}}

\begin{{document}}
\maketitle
prova{}
\end{{document}}
  ]], { i(1, ""), i(2, ""), i(3, ""), i(0, "") })
      ),

      s("fig",
        fmt([[
    \begin{{center}}
      \includegraphics{{Images/{} }}
    \end{{center}}
    ]],
          { i(1, "") })
      ),

      s("def",
        fmt([[
        \begin{{definizione}}{{{}}}
          {}
        \end{{definizione}}
    ]],
          { i(1), i(0) })
      ),

      s("formula",
        fmt([[
    \formula{{{}}}{{
      {}
    }}
    ]],
          { i(1), i(0) })
      ),
      s("teo",
        fmt([[
        \begin{{teorema}}{{{}}}
          {}
        \end{{teorema}}
    ]],
          { i(1), i(0) })
      ),

      s("ref",
        fmt([[
      \ref{{{}}}
    ]],
          { i(1) })
      ),

      s("bbox",
        fmt([[
      \bigbox{{
      {}
      }}
    ]],
          { i(1) })
      ),

      s("vv",
        fmt([[
      \vec{{{}}}
    ]],
          { i(1) })
      ),

      s("vs",
        fmt([[
      \vskip3mm
    ]],
          {})
      ),

      s("selected", { t("prova"), f(function(args, snip)
        local res = {}
        for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
        return res
      end) }),

      s("visual",
        fmt([[
    f(function(args ,snip)
      local res = {{}}
      for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
      return res
      end)
    ]],
          {})
      ),

      s("time", f(function() return os.date("%X") end)),
      s("inc", { t("\\incomprensione{"), f(function() return os.date("%X") end), t("}") }),

      s("cha",
        fmt([[
      \chapter{{{}}}
    ]],
          { i(1) })
      ),

      s("sec",
        fmt([[
      \section{{{}}}
    ]],
          { i(1) })
      ),

      s("sub",
        fmt([[
      \subsection{{{}}}
    ]],
          { i(1) })
      ),

      s("ssub",
        fmt([[
      \subsubsection*{{{}}}
    ]],
          { i(1) })
      ),

      s("i", fmt([[
  \item {}
  i
  ]], { i(1) }),
        {
          condition = function()
            local c = MoonTex.context()
            return (c == "enumerate" or c == "itemize")
          end
        }),

      s("Table",
        fmt([[
    \begin{{table}}[H]
      \centering
      \begin{{tabular}}{{{}}}
        {}
      \end{{tabular}}
    \end{{table}}
    ]],
          { i(1), i(0) })
      ),
      s("table",
        fmt([[
      \begin{{center}}
        \begin{{tabular}}{{{}}}
          {}
        \end{{tabular}}
      \end{{center}}
    ]],
          { i(1), i(0) })
      ),

      s({ trig = "(%d+)col", regTrig = true },
        {
          d(1, function(_, snip)
            local s = {}
            for index = 1, tonumber(snip.captures[1]) - 1 do
              table.insert(s, i(index))
              table.insert(s, t(" & "))
            end
            table.insert(s, i(tonumber(snip.captures[1])))
            table.insert(s, t({ " \\\\ ", snip.captures[1] .. "col" }))
            table.insert(s, i(0))
            return sn(1, s)
          end)
        },
        {
          condition = function()
            local env = MoonTex.context()
            return (env == "tabular" or env == "math")
          end
        }
      ),
      --[[
  s({trig = "(%d+)(%a)(b?)", regTrig=true},
    {
      d(1, function(_, snip)
        local s = {}
        if snip.captures[3] ~= "" then
            table.insert(s, t("|"))
          for index = 1,tonumber(snip.captures[1]) do
            table.insert(s, t(snip.captures[2].."|"))
          end
        else
            table.insert(s, t("|"))
          for index = 1,tonumber(snip.captures[1]) do
            table.insert(s, t(snip.captures[2]))
          end
            table.insert(s, t("|"))
        end
        return sn (1, s)
      end)
    }),
]] --
      s("bisect",
        fmt([[
    \begin{{minipage}}[t]{{0.48\textwidth}}
      {}
    \end{{minipage}}
    %
    \begin{{minipage}}[t]{{0.48\textwidth}}
      {}
    \end{{minipage}}
    ]],
          { i(1), i(2) })
      ),
      s({ trig = "alpha", wordTrig = false }, t("$ \\alpha $")),
      s({ trig = "beta", wordTrig = false }, t("$ \\beta $")),
      s({ trig = "gamma", wordTrig = false }, t("$ \\gamma $")),
      s({ trig = "delta", wordTrig = false }, t("$ \\delta $")),
      s({ trig = "epsilon", wordTrig = false }, t("$ \\varepsilon $")),
      s({ trig = "zeta", wordTrig = false }, t("$ \\zeta $")),
      s({ trig = "eta", wordTrig = false }, t("$ \\eta $")),
      s({ trig = "theta", wordTrig = false }, t("$ \\theta $")),
      s({ trig = "iota", wordTrig = false }, t("$ \\iota $")),
      s({ trig = "kappa", wordTrig = false }, t("$ \\kappa $")),
      s({ trig = "lambda", wordTrig = false }, t("$ \\lambda $")),
      s({ trig = "mu", wordTrig = false }, t("$ \\mu $")),
      s({ trig = "nu", wordTrig = false }, t("$ \\nu $")),
      s({ trig = "xi", wordTrig = false }, t("$ \\xi $")),
      s({ trig = "omicron", wordTrig = false }, t("$ \\omicron $")),
      s({ trig = "pi", wordTrig = false }, t("$ \\pi $")),
      s({ trig = "rho", wordTrig = false }, t("$ \\rho $")),
      s({ trig = "sigma", wordTrig = false }, t("$ \\sigma $")),
      s({ trig = "tau", wordTrig = false }, t("$ \\tau $")),
      s({ trig = "upsilon", wordTrig = false }, t("$ \\upsilon $")),
      s({ trig = "phi", wordTrig = false }, t("$ \\phi $")),
      s({ trig = "chi", wordTrig = false }, t("$ \\chi $")),
      s({ trig = "psi", wordTrig = false }, t("$ \\psi $")),
      s({ trig = "omega", wordTrig = false }, t("$ \\omega $")),

      s({ trig = "fullplot", wordTrig = true }, fmt([[
\begin{{tikzpicture}}
	\begin{{axis}}[
	xmin={}, xmax={},
	ymin={},ymax={},
	restrict y to domain = {}:{}, domain={}:{}, width=0.98\textwidth, height=0.5\textwidth, grid=major, samples=200,  ylabel=$f(x)$, xlabel=$x$, legend entries={{$ $}}]
	\addplot[black, thick] {{{}}};{}
	\end{{axis}}
\end{{tikzpicture}}
  ]], { i(1, "0"), i(2, "5"), i(3, "-4"), i(4, "4"), rep(3), rep(4), rep(1), rep(2), i(5), i(0) })),
      s({ trig = "halfplot", wordTrig = true }, fmt([[
\begin{{tikzpicture}}
	\begin{{axis}}[
	xmin={}, xmax={},
	ymin={},ymax={},
	restrict y to domain = {}:{}, domain={}:{}, width=0.48\textwidth, height=0.48\textwidth, grid=major, samples=200,  ylabel=$f(x)$, xlabel=$x$, legend entries={{$ $}}]
	\addplot[black, thick] {{{}}};{}
	\end{{axis}}
\end{{tikzpicture}}
  ]], { i(1, "0"), i(2, "5"), i(3, "-4"), i(4, "4"), rep(3), rep(4), rep(1), rep(2), i(5), i(0) })),
      s({ trig = "fdot(%-?%d+%.?%d*)", regTrig = true },
        f(function(_, snip)
          local res = nil
          for _, ele in ipairs(snip.env.LS_SELECT_RAW) do
            if res == nil then res = ele else res = res .. ele end
          end
          local number = snip.captures[1]:sub(1, 1) == "-" and "(" .. snip.captures[1] .. ")" or snip.captures[1]
          return { res:match("%s*(.*)"),
            "\\node [blackdot] at (" .. snip.captures[1] .. ", {" .. res:match("{(.*)}"):gsub("x", number) .. "}) {};" }
        end),
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),

      s({ trig = "fedot(%-?%d+%.?%d*)", regTrig = true },
        f(function(_, snip)
          local res = nil
          for _, ele in ipairs(snip.env.LS_SELECT_RAW) do
            if res == nil then res = ele else res = res .. ele end
          end
          local number = snip.captures[1]:sub(1, 1) == "-" and "(" .. snip.captures[1] .. ")" or snip.captures[1]
          return { res:match("%s*(.*)"),
            "\\node [whitedot] at (" .. snip.captures[1] .. ", {" .. res:match("{(.*)}"):gsub("x", number) .. "}) {};" }
        end),
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),

      s({ trig = "fcord(%-?%d+%.?%d*)", regTrig = true },
        { f(function(_, snip)
          local res = nil
          for _, ele in ipairs(snip.env.LS_SELECT_RAW) do
            if res == nil then res = ele else res = res .. ele end
          end
          return { res:match("%s*(.*)"), "\\coordinate (" }
        end), i(1),
          f(function(_, snip)
            local res = nil
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do
              if res == nil then res = ele else res = res .. ele end
            end
            local number = snip.captures[1]:sub(1, 1) == "-" and "(" .. snip.captures[1] .. ")" or snip.captures[1]
            return ") at (" .. snip.captures[1] .. ", {" .. res:match("{(.*)}"):gsub("x", number) .. "}) {};"
          end)
        },
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s("dot", fmt([[\node [blackdot] at ({},{}){{}};]], { i(1), i(2) }),
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s("edot", fmt([[\node [whitedot] at ({},{}){{}};]], { i(1), i(2) }),
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s("shift", fmt([[[shift={{(axis direction cs:{},{})}}] {}]], { i(1), i(2), i(3) }),
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s("draw", fmt([[\draw ({})--({});]], { i(1), i(2) }), {
        condition = function()
          local env = MoonTex.context()
          return env == "axis" or env == "tikzpicture" or env == "circuitikz"
        end
      }),
      s("dashed", fmt([[\draw [dashed] ({})--({});]], { i(1), i(2) }),
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s("dotted", fmt([[\draw [dotted] ({})--({});]], { i(1), i(2) }),
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),

      s({ trig = "addnodes/(.*)", regTrig = true },
        f(function(_, snip)
          local res = {}
          for _, ele in ipairs(snip.env.LS_SELECT_DEDENT) do table.insert(res, ele) end

          table.insert(res, "%")

          for _, ele in ipairs(snip.env.LS_SELECT_RAW) do
            table.insert(res, "\\node [" .. snip.captures[1] .. "] at " .. ele:match("(%(.*%)).*at") .. " {};")
          end
          return res
        end),
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture"
          end
        }),
      s({ trig = "nn", wordTrig = true },
        fmt([[
    \node ({})[{}] {} {{{}}};
    ]], { rep(3), i(1), i(2), i(3) })
        ,
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s({ trig = "shift", wordTrig = true }, { t("\\[shift={("), i(1), t(")}] ") },
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s("VV", fmt([[\verb|{}|]], { i(1) })),
      s("list", fmt([[\begin{{lstlisting}}[language = java, frame = none]
  {}
\end{{lstlisting}}]], { i(0) })),

      s({ trig = "(-?%d+)tree", regTrig = true },
        fmt([[
	\begin{{forest}}
		for tree={{draw, grow = {}}}
    {}
	\end{{forest}}
    ]],
          { f(function(_, snip) return snip.captures[1] end), i(0) })
      ),

      s({ trig = "ER", wordTrig = true },
        fmt([[
    \begin{{tikzpicture}}[node distance = 7 em]
      {}
    \end{{tikzpicture}}
    ]], { i(0) })
      ),

      s({ trig = "ER", wordTrig = true },
        fmt([[
    \begin{{tikzpicture}}[node distance = 7 em]
      {}
    \end{{tikzpicture}}
    ]], { i(0) })
      ),

      s({ trig = "tikz", wordTrig = true },
        fmt([[
    \begin{{tikzpicture}}
      {}
    \end{{tikzpicture}}
    ]], { i(0) })
      ),
      s("link", fmt([[\href{{{}}}{{{}}}]], {

        d(1, function(args)
          local clipboard = vim.fn.getreg('+')
          local ghost_text = not clipboard:match("\n") and clipboard or "link"
          return sn(nil, {
            i(1, ghost_text)
          })
        end), -- Questo nodo ritorna come contenuto di default il conetuto della clipboard
        i(2, "name"),
      })),

      s("href", fmt([[\hyperref[{}]{{{}}}]], {
        d(1, function(args)
          local clipboard = vim.fn.getreg('+')
          local ghost_text = not clipboard:match("\n") and clipboard or "label"
          return sn(nil, {
            i(1, ghost_text)
          })
        end), -- Questo nodo ritorna come contenuto di default il conetuto della clipboard
        i(2, "name"),
      })),

      s("hr", { t("\\vskip3mm\\hrule\\vskip3mm") }),

    },

    {

      s("MC",
        fmt([[
    \mathcal{{{}}}
    ]],
          { i(1) }),
        { condition = function() return MoonTex.context() == "math" end }
      ),

      s("ll",
        fmt([[
     \label{{{}}}
    ]],
          { i(1) })
      ),

      s("BB",
        fmt([[
      \mathbb{{{}}}
    ]],
          { i(1) })
      ),


      s("bin",
        fmt([[
      \binom{{{}}}{{{}}}
    ]],
          { i(1), i(2) }),
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s("ge",
        fmt([[
      \ge
    ]],
          {}),
        { condition = function() return MoonTex.context() == "math" end }
      ),

      s("le",
        fmt([[
      \le
    ]],
          {}),
        { condition = function() return MoonTex.context() == "math" end }
      ),

      s("NN",
        fmt([[
      \N
    ]],
          {})
      ),

      s("RR",
        fmt([[
      \R
    ]],
          {})
      ),

      s("CC",
        fmt([[
      \C
    ]],
          {})
      ),

      s("QQ",
        fmt([[
      \Q
    ]],
          {})
      ),

      s("ZZ",
        fmt([[
      \Z
    ]],
          {})
      ),

      s("neq",
        fmt([[
      \neq
    ]],
          {}),
        { condition = function() return MoonTex.context == "math" end }
      ),

      s("tc",
        fmt([[
       \text{{ t.c. }}
    ]],
          {})
      ),

      s("beg",
        fmt([[
      \begin{{{}}}
        {}{}
      \end{{{}}}
    ]],
          { i(1),
            f(function(args, snip)
              local res = {}
              for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
              return res
            end),
            i(0),
            rep(1) })
      ),


      s("cc",
        fmt([[
    \begin{{center}}
      {}{}
    \end{{center}}]],
          { f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end)
          , i(1) })
      ),

      s("tb", { t("\\textbox{"),
        f(function(args, snip)
          local res = {}
          for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
          return res
        end),
        i(1), t("}") }),


      s("bbf",
        fmt([[
      \textbf{{{}{}}}
    ]],
          { f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end),
            i(1)
          })
      ),

      s("iit",
        fmt([[
      \textit{{{}{}}}
    ]],
          { f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end),
            i(1)
          })
      ),

      s("uul",
        fmt([[
      \underline{{{}{}}}
    ]],
          { f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end),
            i(1)
          })
      ),

      s("abs",
        fmt([[
      \left|{}{}\right|
    ]],
          { f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end),
            i(1) }),
        { condition = function() return MoonTex.context() == "math" end }
      ),

      s("enum",
        fmt([[
    \begin{{enumerate}}
      \item {}
      i{}
    \end{{enumerate}}
    ]],
          { i(1), i(0) })
      ),

      s({ trig = "item", wordTrig = true },
        fmt([[
    \begin{{itemize}}
      \item {}
      i{}
    \end{{itemize}}
    ]],
          { i(1), i(0) })
      ),

      s("km", { t("$ "),
        f(function(args, snip)
          local res = {}
          for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
          return res
        end),
        i(1), t(" $") }),

      s("dm",
        fmt([[
    \[
    {}{}
    \]
    ]],
          { f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end),
            i(1) })
      ),

      s("ali",
        fmt([[
    \begin{{align*}}
      {}{}
    \end{{align*}}
    ]],
          { f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end),
            i(1) })
      ),

      s("//",
        fmt([[
      \frac{{{}{}}}{{{}}}
    ]],
          { f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end), i(1), i(2) }),
        { condition = function() return MoonTex.context() == "math" end }
      ),

      s("==", t("&="), { condition = function() return MoonTex.context() == "align*" end }),
      s("!=", t("\\neq ")),
      s("ceil",
        fmt([[
      \left\lceil {} \right\rceil
    ]],
          { i(1) })
      ),
      s("floor",
        fmt([[
      \left\lflooor {} \right\rightfloor
    ]],
          { i(1) })
      ),
      s("pmat",
        fmt([[
    \begin{{pmatrix}}
      {}
    \end{{pmatrix}}
    ]],
          { i(0) })
      ),
      s("bmat",
        fmt([[
    \begin{{bmatrix}}
      {}
    \end{{bmatrix}}
    ]],
          { i(0) })
      ),
      s({ trig = "()", wordTrig = false, priority = 1001 }, { t("\\left("),
          f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end), i(1, ""), t("\\right)") },
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "[]", wordTrig = false, priority = 1001 }, { t("\\left["),
          f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end), i(1, ""), t("\\right]") },
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "{}", wordTrig = false, priority = 1001 }, { t("\\left{"),
          f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end), i(1, ""), t("\\right}") },
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "<>", wordTrig = false, priority = 1001 }, { t("\\left<"),
          f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end), i(1, ""), t("\\right>") },
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "set", wordTrig = true }, { t("\\left\\{"),
          f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end), i(1, ""), t("\\right\\}") },
        { condition = function() return MoonTex.context() == "math" end }
      ),

      s("OH",
        fmt([[
      \overline{{{}{}}}
    ]],
          { f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end),
            i(1) })
      ),

      s("sum",
        fmt([[
    \sum_{{k={}}}^{{{}}} {}
    ]],
          { i(1, "1"), i(2, "\\infty"), i(0, "a_k x^k") }),
        { condition = function() return MoonTex.context() == "math" end }),
      s("lim",
        fmt([[
    \lim_{{{} \to {}}} {}
    ]],
          { i(1, "x"), i(2, "\\infty"), i(0, "f(x)") }),
        { condition = function() return MoonTex.context() == "math" end }),
      s("prod",
        fmt([[
    \prod_{{k={}}}^{{{}}} {}
    ]],
          { i(1, "1"), i(2, "\\infty"), i(0, "a_k x^k") }),
        { condition = function() return MoonTex.context() == "math" end }),

      s({ trig = "sq", wordTrig = false },
        fmt([[
      \sqrt{{{}{}}}
    ]],
          { f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end),
            i(1) }),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "sr", wordTrig = false }, t("^2 "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "cb", wordTrig = false }, t("^3 "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "td", wordTrig = false }, { t("^{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "__", wordTrig = false }, { t("_{"), i(1), t("}") }),
      s({ trig = "inf", wordTrig = false }, t("\\infty "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "EE", wordTrig = false }, t("\\exists "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "forall", wordTrig = false }, t("\\forall "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "xx", wordTrig = false }, t("\\times "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "...", wordTrig = false }, t("\\ldots "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "**", wordTrig = false }, t("\\cdot "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "norm", wordTrig = false }, { t(" \\|"), f(function(args, snip)
        local res = {}
        for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
        return res
      end), i(1), t("\\|") }, { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "dint", wordTrig = false },
        fmt([[
    \int_{{{}}}^{{{}}} {} \; dx
    ]],
          { i(1, "a"), i(2, "b"), i(3, "f(x)") }),
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "inv", wordTrig = false }, t("^{-1}"), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "inn", wordTrig = false, priority = 1001 }, t("\\in "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "uu", wordTrig = false }, t("\\cup "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "UU", wordTrig = false }, t("\\bigcup "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "nn", wordTrig = false }, t("\\cap "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "eset", wordTrig = false }, t("\\emptyset "),
        { condition = function() return MoonTex.context() == "math" end }),
      s("tt", { t("\\text{ "), f(function(args, snip)
        local res = {}
        for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
        return res
      end),
        i(1), t(" }") }, { condition = function() return MoonTex.context() == "math" end }),
      s("case",
        fmt([[
      \begin{{cases}}
        {}
      \end{{cases}}
    ]],
          { i(1) })
      ),
      s("rarr", t("\\rightarrow ")),
      s("larr", t("\\leftarrow ")),
      s("Rarr", t("\\Rightarrow ")),
      s("Larr", t("\\Leftarrow ")),
      s("iif", t("\\Leftrightarrow ")),
      s("iif", t("\\Leftrightarrow ")),
      s("qu", t("\\quad "), { condition = function() return MoonTex.context() == "math" end }),
      s("to", t("\\to "), { condition = function() return MoonTex.context() == "math" end }),
      s("not", t("\\not "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "vv([a-zA-Z]) ", regTrig = true },
        { t("\\vec{"), f(function(_, snip) return snip.captures[1] end), t("}") }),
      s("ub", { t("\\underbracket[0.1ex]{"),
          f(function(args, snip)
            local res = {}
            for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
            return res
          end),
          t("}_{"), i(1), t("}"), i(0) },
        { condition = function() return MoonTex.context() == "math" end }),

      --  s("comm", {f(function(text, snip)
      --  local comment_tokens = {lua = "--", cpp = "//", latex = "%"}
      --  local curr_token = comment_tokens[vim.bo.filetype]==nil and "" or comment_tokens[vim.bo.filetype]
      --  if next(snip.env.LS_SELECT_RAW)==nil then return curr_token end
      --  local lines = {}
      --  for _, x in ipairs(snip.env.LS_SELECT_RAW) do table.insert(lines, curr_token..x) end
      --  return lines
      --  end)})

      -- snippet per la \frac{}{}
      s({ trig = "(%-?%d+)/", regTrig = true, wordTrig = false },
        { t("\\frac{"), f(function(_, snip) return snip.captures[1] end), t("}{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "(%-?%(.+%))/", regTrig = true, wordTrig = false },
        { t("\\frac{"), f(function(_, snip) return snip.captures[1] end), t("}{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "(%-?\\left%(.*\\right%))/", regTrig = true, wordTrig = false, priority = 1002 },
        { t("\\frac{"), f(function(_, snip) return snip.captures[1] end), t("}{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "(%-?%d+\\?%a*%^?%d*)/", regTrig = true, priority = 1001, wordTrig = false },
        { t("\\frac{"), f(function(_, snip) return snip.captures[1] end), t("}{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "(%-?%d*\\?%a+%^?%d*)/", regTrig = true, priority = 1001, wordTrig = false },
        { t("\\frac{"), f(function(_, snip) return snip.captures[1] end), t("}{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "(%-?%d*\\?%a*%^%d+)/", regTrig = true, priority = 1001, wordTrig = false },
        { t("\\frac{"), f(function(_, snip) return snip.captures[1] end), t("}{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "(%-?%d*\\?%a*%^{.*})/", regTrig = true, priority = 1001, wordTrig = false },
        { t("\\frac{"), f(function(_, snip) return snip.captures[1] end), t("}{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "(%-?\\frac{.*}{.*})/", regTrig = true, priority = 1001, wordTrig = false },
        { t("\\frac{"), f(function(_, snip) return snip.captures[1] end), t("}{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "(%a)(%d)", regTrig = true },
        { f(function(_, snip) return snip.captures[1] end), t("_"), f(function(_, snip) return snip.captures[2] end) },
        { condition = function() return MoonTex.context() == "math" end }
      ),
      s({ trig = "alpha", wordTrig = true, priority = 1001 }, t("\\alpha "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Alpha", wordTrig = true, priority = 1001 }, t("\\Alpha "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "beta", wordTrig = true, priority = 1001 }, t("\\beta "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Beta", wordTrig = true, priority = 1001 }, t("\\Beta "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "gamma", wordTrig = true, priority = 1001 }, t("\\gamma "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Gamma", wordTrig = true, priority = 1001 }, t("\\Gamma "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "delta", wordTrig = true, priority = 1001 }, t("\\delta "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Delta", wordTrig = true, priority = 1001 }, t("\\Delta "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "epsilon", wordTrig = true, priority = 1001 }, t("\\varepsilon "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Epsilon", wordTrig = true, priority = 1001 }, t("\\Varepsilon "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "zeta", wordTrig = true, priority = 1001 }, t("\\zeta "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Zeta", wordTrig = true, priority = 1001 }, t("\\Zeta "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "eta", wordTrig = true, priority = 1001 }, t("\\eta "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Eta", wordTrig = true, priority = 1001 }, t("\\Eta "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "theta", wordTrig = true, priority = 1001 }, t("\\theta "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Theta", wordTrig = true, priority = 1001 }, t("\\Theta "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "iota", wordTrig = true, priority = 1001 }, t("\\iota "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Iota", wordTrig = true, priority = 1001 }, t("\\Iota "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "kappa", wordTrig = true, priority = 1001 }, t("\\kappa "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Kappa", wordTrig = true, priority = 1001 }, t("\\Kappa "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "lambda", wordTrig = true, priority = 1001 }, t("\\lambda "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Lambda", wordTrig = true, priority = 1001 }, t("\\Lambda "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "mu", wordTrig = true, priority = 1001 }, t("\\mu "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Mu", wordTrig = true, priority = 1001 }, t("\\Mu "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "nu", wordTrig = true, priority = 1001 }, t("\\nu "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Nu", wordTrig = true, priority = 1001 }, t("\\Nu "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "xi", wordTrig = true, priority = 1001 }, t("\\xi "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Xi", wordTrig = true, priority = 1001 }, t("\\Xi "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "omicron", wordTrig = true, priority = 1001 }, t("\\omicron "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Omicron", wordTrig = true, priority = 1001 }, t("\\Omicron "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "pi", wordTrig = true, priority = 1001 }, t("\\pi "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Pi", wordTrig = true, priority = 1001 }, t("\\Pi "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "rho", wordTrig = true, priority = 1001 }, t("\\rho "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Rho", wordTrig = true, priority = 1001 }, t("\\Rho "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "sigma", wordTrig = true, priority = 1001 }, t("\\sigma "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Sigma", wordTrig = true, priority = 1001 }, t("\\Sigma "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "tau", wordTrig = true, priority = 1001 }, t("\\tau "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Tau", wordTrig = true, priority = 1001 }, t("\\Tau "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "upsilon", wordTrig = true, priority = 1001 }, t("\\upsilon "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Upsilon", wordTrig = true, priority = 1001 }, t("\\Upsilon "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "phi", wordTrig = true, priority = 1001 }, t("\\phi "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Phi", wordTrig = true, priority = 1001 }, t("\\Phi "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "chi", wordTrig = true, priority = 1001 }, t("\\chi "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Chi", wordTrig = true, priority = 1001 }, t("\\Chi "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "psi", wordTrig = true, priority = 1001 }, t("\\psi "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Psi", wordTrig = true, priority = 1001 }, t("\\Psi "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "omega", wordTrig = true, priority = 1001 }, t("\\omega "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Omega", wordTrig = true, priority = 1001 }, t("\\Omega "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "minus", wordTrig = true }, t("\\setminus "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "inn", wordTrig = true }, t("\\in "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "neq", wordTrig = true }, t("\\neq "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "mod", wordTrig = true }, t("\\mod "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "equiv", wordTrig = true }, t("\\equiv "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "sim", wordTrig = true }, t("\\sim "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "var", wordTrig = true }, t("\\Var "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "pr", wordTrig = true }, t("\\Pr "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "ON", wordTrig = true }, { t("\\operatorname{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "z(%a)z", regTrig = true },
        { t("\\Z/_{"), f(function(_, snip) return snip.captures[1] end), t("\\Z} ") },
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "hl", wordTrig = true }, t("\\hline"),
        { condition = function() return MoonTex.context() == "tabular" end }),
      s({ trig = "hat", wordTrig = true }, { t("\\hat{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "xarr", wordTrig = true }, { t("\\xrightarrow{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "xarr", wordTrig = true }, { t("\\xrightarrow{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "sin", wordTrig = true }, t("\\sin "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "cos", wordTrig = true }, t("\\cos "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "tan", wordTrig = true }, t("\\tan "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "map", wordTrig = true }, t("\\mapsto "),
        { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "log", wordTrig = true }, t("\\log "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Im", wordTrig = true }, t("\\IM "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "Re", wordTrig = true }, t("\\RE "), { condition = function() return MoonTex.context() == "math" end }),
      s({ trig = "VV", wordTrig = true }, { t("\\verb|"), i(1), t("|") }),
      s({ trig = "oname", wordTrig = true }, { t("\\operatorname{"), i(1), t("}") },
        { condition = function() return MoonTex.context() == "math" end }),

      s({ trig = "AT", wordTrig = true },
        fmt([[
    \node ({})[attribute, {}] {{{}}};
    ]], { rep(2), i(1), i(2) })
        ,
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s({ trig = "EE", wordTrig = true },
        fmt([[
    \node ({})[entity, {}] {{{}}};
    ]], { rep(2), i(1), i(2) })
        ,
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s({ trig = "RR", wordTrig = true, priority = 1001 },
        fmt([[
    \node ({})[relationship, {}] {{{}}};
    ]], { rep(2), i(1), i(2) })
        ,
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s({ trig = "WW", wordTrig = true }, t("above of = ")
        ,
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s({ trig = "SS", wordTrig = true }, t("below of = ")
        ,
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s({ trig = "AA", wordTrig = true }, t("left of = ")
        ,
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s({ trig = "DD", wordTrig = true }, t("right of = ")
        ,
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s({ trig = "WD", wordTrig = true }, t("above right of = ")
        ,
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s({ trig = "WA", wordTrig = true }, t("above left of = ")
        ,
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s({ trig = "SA", wordTrig = true }, t("below left of = ")
        ,
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),
      s({ trig = "SD", wordTrig = true }, t("below right of = "),
        {
          condition = function()
            local env = MoonTex.context()
            return env == "axis" or env == "tikzpicture" or env == "circuitikz"
          end
        }),



    }
