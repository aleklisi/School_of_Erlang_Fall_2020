-module(pgsql_backend_SUITE).

%% Based on https://erlang.org/doc/apps/common_test/example_chapter.html#test-suite-example

-include_lib("common_test/include/ct.hrl").

-compile(export_all).

init_per_suite(Config) ->
    Config.

end_per_suite(_Config) ->
    ok.
init_per_testcase(_Case, Config) ->
    {ok, Pid} = pgsql_backend:start_link([]),
    [{conn, Pid} | Config].

end_per_testcase(_Case, _Config) ->
    ok.

all() ->
    [
        when_requested_all_users_are_returned
    ].

 %%--------------------------------------------------------------------
 %% TEST CASES
 %%--------------------------------------------------------------------

when_requested_all_users_are_returned(Config) ->
    Pid = proplists:get_value(conn, Config),
    Users = gen_server:call(Pid, get_all_users),
    2 = length(Users),
    % 3 = length(Users),
    [] = Users -- [<<"Aleksander">>, <<"Rick">>, <<"Morty">>].

