return {
    },

    {

      s({ trig = "()", wordTrig = false }, { t("("),
        f(function(args, snip)
          local res = {}
          for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
          return res
        end), i(1, ""), t(")") }),
      s({ trig = "{}", wordTrig = false }, { t("{"),
        f(function(args, snip)
          local res = {}
          for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
          return res
        end)
        , i(1, ""), t("}") }),
      s({ trig = "[]", wordTrig = false }, { t("["),
        f(function(args, snip)
          local res = {}
          for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
          return res
        end)
        , i(1, ""), t("]") }),
      s({ trig = "\"\"", wordTrig = false }, { t("\""),
        f(function(args, snip)
          local res = {}
          for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
          return res
        end)
        , i(1, ""), t("\"") }),
      s({ trig = "<>", wordTrig = false }, { t("<"),
        f(function(args, snip)
          local res = {}
          for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
          return res
        end)
        , i(1, ""), t(">") }),
      s({ trig = "''", wordTrig = false }, { t("'"),
        f(function(args, snip)
          local res = {}
          for _, ele in ipairs(snip.env.LS_SELECT_RAW) do table.insert(res, ele) end
          return res
        end)
        , i(1, ""), t("'") }),

    }
