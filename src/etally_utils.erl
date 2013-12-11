-module(etally_utils).
-export([call_cnode/2,
         cast_cnode/2]).


call_cnode(Msg, Node) ->
    {any, Node} ! {call, self(), Msg},
    receive
	{tally, Result} ->
	    Result
    after 5000 ->
            io:fwrite("etally, did not recieve message"),
            ok
    end.

cast_cnode(Msg, Node) ->
    {any, Node} ! {cast, self(), Msg},
    ok.
    
