-module(etally_metric).
-export([send_event/4, get_counter/2,
         get_leaderboard/4, list_leaderboards/1,
         send_event_bootstrap/5]).

-spec send_event(Ls, LBBindings, Percents, Payload, Node) -> ok when
      Ls         :: [binary()],
      LBBindings :: [{binary(), binary()}],
      Percents   :: [binary()],
      Payload    :: pos_integer(),
      Node       :: atom().

send_event(Ls, LBBindings, Percents, Payload, Node) ->
    etally_utils:cast_cnode({metric_event, Ls, LBBindings, Percents, Payload}, Node).


-spec send_event_bootstrap(Ls, LBBindings, Percents, Ts, Payload, Node) -> ok when
      Ls         :: [binary()],
      LBBindings :: [{binary(), binary()}],
      Percents   :: [binary()],
      Ts         :: pos_integer(),
      Payload    :: pos_integer(),
      Node       :: atom().

send_event_bootstrap(Ls, LBBindings, Percents, Ts, Payload, Node) ->
    etally_utils:cast_cnode({metric_event_tz, Ls, LBBindings, Percents, Ts, Payload}, Node).


-spec get_counter(Name, Node) -> ok when
      Name :: binary(),
      Node :: atom().

get_counter(Name, Node) ->
    etally_utils:call_cnode({metric_get_counter, Name}, Node).


get_leaderboard(Name, Interval,Page,  Node) ->
    etally_utils:call_cnode({metric_get_leaderboard, Name, Interval, Page}, Node).

list_leaderboards(Node) ->
    etally_utils:call_cnode({metric_list_leaderboards}, Node).

