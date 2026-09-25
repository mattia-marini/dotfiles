return{	

  s("in", fmt([[FILE * in = fopen({}, "r");]], {i(1, "\"input.txt\"")})),
  s("out", fmt([[FILE * out = fopen({}, "w");]], {i(1, "\"output.txt\"")})),

  s("main", fmt([[
    #include <stdio.h>
    #include <stdlib.h>
    #include <errno.h>
    #include <signal.h>
    #include <sys/types.h>
    #include <sys/msg.h>
    #include <sys/ipc.h>
    #include <sys/wait.h>
    #include <unistd.h>
    #include <string.h>
    #include <fcntl.h>

    int main(int argc, char *argv[]){{
      {}
    }}]],
    {i(0,"")} )),

  s("pp", 
    fmt([[print("{}");]],
    {i(1)})
  ),

  s("struct",
    fmt([[
    struct {} {{
      {} (){{}}
    }};
    ]],
      {i(1), rep(1)})
  ),

  s({trig = "for", wordTrig=true}, fmt([[
  for(int i = 0; i<{}; i++){{
    {}
  }}
  ]], {i(1),i(0)})),

  s({trig = "for(%a)", wordTrig=true, regTrig=true}, fmt([[
  for(int {} = 0; {}<{}; {}++){{
    {}
  }}
  ]], {f(function(_, snip) return snip.captures[1] end),
        f(function(_, snip) return snip.captures[1] end), i(1), f(function(_, snip) return snip.captures[1] end) ,i(0)})),
},

{

}
