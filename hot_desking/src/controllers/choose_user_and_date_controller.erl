-module(choose_user_and_date_controller).

-export([index/1]).

index(#{req := #{path := <<"/choose_user_and_date">>}}) ->
    {ok, []};
index(#{req := #{path := <<"/all_users">>}}) ->
    Response = maybe_start_db_and_get_all_the_users(),
    {json, Response}.

% TODO handle starting and requesting data form pgsql correctly
maybe_start_db_and_get_all_the_users() ->
    DbPid = case pgsql_backend:start_link(db) of
        {ok, Pid} -> Pid;
        {error, {already_started, Pid}} -> Pid
    end,
    gen_server:call(DbPid, get_all_users).