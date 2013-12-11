-module(etally_count).
-export([send_event/3,
         get_counter/2,
         get_leaderboard/4,
         list_leaderboards/1,
         send_event_bootstrap/4,
         order/1]).

-spec send_event(Ls, LBBindings, Node) -> ok when
      Ls ::  [binary()],
      LBBindings :: [{binary(), binary()}],
      Node :: atom().

send_event(Ls, LBBindings, Node) ->
    etally_utils:cast_cnode({count_event, Ls, LBBindings}, Node).


-spec send_event_bootstrap(Ls, LBBindings, Ts, Node) -> ok when
      Ls         :: [binary()],
      LBBindings :: [{binary(), binary()}],
      Ts         :: pos_integer(),
      Node       :: atom().

send_event_bootstrap(Ls, LBBindings, Ts, Node) ->
    etally_utils:cast_cnode({count_event_tz, Ls, LBBindings, Ts}, Node).


-spec get_counter(Name, Node) -> ok when
      Name :: binary(),
      Node :: atom().

get_counter(Name, Node) ->
    etally_utils:call_cnode({count_get_counter, Name}, Node).


order(Node) ->
    etally_utils:cast_cnode({count_order}, Node).

start(Node) ->
    etally_utils:cast_cnode({system_start}, Node).


get_leaderboard(Name, Interval,Page,  Node) ->
    etally_utils:call_cnode({count_get_leaderboard, Name, Interval, Page}, Node).


list_leaderboards(Node) ->
    etally_utils:call_cnode({count_list_leaderboards}, Node).

