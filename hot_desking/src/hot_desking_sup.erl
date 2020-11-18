%%%-------------------------------------------------------------------
%% @doc hot_desking top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(hot_desking_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    % https://erlang.org/doc/man/os.html#getenv-1
    PgsqlParams = #{
        host => os:getenv("POSTGRESQL_URL"),
        port => list_to_integer(os:getenv("POSTGRESQL_PORT")),
        username => os:getenv("POSTGRESQL_USERNAME"),
        password => os:getenv("POSTGRESQL_PASSWORD"),
        database => os:getenv("POSTGRESQL_DATABASE"),
        timeout => 4000
    },
    Children = [
        #{
            id => db_pool,
            start =>
                {wpool, start_pool, [
                    db_worker_pool,
                    [
                        {worker, {pgsql_backend, PgsqlParams}},
                        {workers, 5}
                    ]
                ]}
        }
        ],
    {ok, { {one_for_all, 0, 1}, Children} }.

%%====================================================================
%% Internal functions
%%====================================================================
