-module(etally).
-export([send_event/3, get_counter/2,
         get_leaderboard/3, list_leaderboards/1]).

-spec send_event(Ls, LBBindings, Node) -> ok when
      Ls ::  [binary()],
      LBBindings :: [{binary(), binary()}],
      Node :: atom().

send_event(Ls, LBBindings, Node) ->
    cast_cnode({event, Ls, LBBindings}, Node).


-spec get_counter(Name, Node) -> ok when
      Name :: binary(),
      Node :: atom().

get_counter(Name, Node) ->
    call_cnode({get_counter, Name}, Node).


get_leaderboard(Name, Interval, Node) ->
    call_cnode({get_leaderboard, Name, Interval}, Node).

list_leaderboards(Node) ->
    call_cnode({list_leaderboards}, Node).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% actual methods for sending the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


call_cnode(Msg, Node) ->
    {any, Node} ! {call, self(), Msg},
    receive
	Result ->
	    Result
    after 5000 ->
            io:fwrite("Error did not recieve message"),
            ok
    end.

cast_cnode(Msg, Node) ->
    {any, Node} ! {call, self(), Msg},
    ok.
    