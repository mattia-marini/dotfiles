return {
      s({ trig = "print(.+)", wordTrig = true, regTrig = true },
        f(function(_, snip)
          local input = snip.captures[1]

          -- Split the input string by commas and store the result in a table
          local variables = {}
          for var in string.gmatch(input, '([^,]+)') do
            table.insert(variables, var)
          end

          -- Create the placeholder string with '{}' repeated as many times as there are variables
          local placeholder_string = string.rep("{:?}", #variables):gsub("{}", "{} ", #variables - 1):gsub("%s+$", "")

          -- Construct the final output
          local final_string = 'println!("' .. placeholder_string .. '", ' .. table.concat(variables, ", ") .. ');'

          -- Print the result
          return final_string
        end)
      ),

      s({ trig = "print", wordTrig = true},{t("println!(\""), i(1), t("\");")}),
      s({ trig = "fn", wordTrig = true},
    fmt([[
    pub fn ({}){{
      {}
    }}
    ]],
      {i(1), i(0)})
  )

    },
    {

    }
