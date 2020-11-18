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
    Children = [
        #{
            id => db,
            start => {pgsql_backend, start_link, [db_worker_name]}
        }
        ],
    {ok, { {one_for_all, 0, 1}, Children} }.

%%====================================================================
%% Internal functions
%%====================================================================
