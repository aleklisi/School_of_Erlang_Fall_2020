-module(choose_user_and_date_controller).

-export([index/1]).

index(#{req := #{path := <<"/choose_user_and_date">>}}) ->
    {ok, []};
index(#{req := #{path := <<"/all_users">>}}) ->
    Response = pgsql_backend:get_all_users(),
    {json, Response}.
