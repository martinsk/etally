-module(etally).
-export([send_event/3, get_counter/2,
         get_leaderboard/3, list_leaderboards/1,
         send_event_bootstrap/4, order/1]).

-spec send_event(Ls, LBBindings, Node) -> ok when
      Ls ::  [binary()],
      LBBindings :: [{binary(), binary()}],
      Node :: atom().

send_event(Ls, LBBindings, Node) ->
    cast_cnode({event, Ls, LBBindings}, Node).


-spec send_event_bootstrap(Ls, LBBindings, Ts, Node) -> ok when
      Ls         :: [binary()],
      LBBindings :: [{binary(), binary()}],
      Ts         :: pos_integer(),
      Node       :: atom().

send_event_bootstrap(Ls, LBBindings, Ts, Node) ->
    cast_cnode({event_tz, Ls, LBBindings, Ts}, Node).


-spec get_counter(Name, Node) -> ok when
      Name :: binary(),
      Node :: atom().

get_counter(Name, Node) ->
    call_cnode({get_counter, Name}, Node).


order(Node) ->
    cast_cnode({order}, Node).


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
	{tally, Result} ->
	    Result
    after 5000 ->
            io:fwrite("Error did not recieve message"),
            ok
    end.

cast_cnode(Msg, Node) ->
    {any, Node} ! {call, self(), Msg},
    ok.
    
