-module(etally).
-export([order/1, start/1]).

order(Node) ->
    etally_utils:cast_cnode({count_order}, Node).

start(Node) ->
    etally_utils:cast_cnode({system_start}, Node).

