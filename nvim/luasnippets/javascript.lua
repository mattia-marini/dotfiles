return {

      s("ifst", t([[std::ifstream in("input.txt");]])),

      s("rfc",
        fmt([[
import React from 'react'
export default function {}({{ children, background }}) {{
  return (
    {}
  )
}}
    ]],
          { i(1), i(0)})
      ),

      s({ trig = "for", wordTrig = true }, fmt([[
  for(let i = 0; i<{}; i++){{
    {}
  }}
  ]], { i(1), i(0) })),

      s({ trig = "for(%a)", wordTrig = true, regTrig = true }, fmt([[
  for(let {} = 0; {}<{}; {}++){{
    {}
  }}
  ]], { f(function(_, snip) return snip.captures[1] end),
        f(function(_, snip) return snip.captures[1] end), i(1), f(function(_, snip) return snip.captures[1] end), i(0) })),

    },

    {
      s("csl", fmt([[console.log({})]], {i(1)} )),
      s("cjr", fmt([[
({}) => {{
  {}
}}
]], {i(1,"e"), i(0)} )),
    }
