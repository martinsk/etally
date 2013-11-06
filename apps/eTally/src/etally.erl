-module(etally).
-export([send_event/1, get_counter/1]).

send_event(Ls) ->
    cast_cnode({event, Ls, []}).
get_counter(Name) ->
    call_cnode({get_counter, Name}).

call_cnode(Msg) ->
    {any, 'cnode@msk-dev.local'} ! {call, self(), Msg},
    receive
	Result ->
	    Result
    after 5000 ->
            io:fwrite("Error did not recieve message"),
            ok
    end.

cast_cnode(Msg) ->
    {any, 'cnode@msk-dev.local'} ! {call, self(), Msg},
    ok.
    
