-module(pgsql_backend).

% Inspiration https://github.com/spawnfest/eneo4j/blob/master/src/eneo4j_worker.erl

-behaviour(gen_server).

%% API
-export([
    start_link/1,
    get_all_users/0
    ]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

start_link(Args) ->
    gen_server:start_link(?MODULE, Args, []).

get_all_users() ->
    wpool:call(db_worker_pool, get_all_users).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

init(Args) ->
    {ok, Conn} = epgsql:connect(Args),
    {ok, #{conn => Conn}}.

handle_call(get_all_users, _From, State = #{conn := Conn}) ->
    {ok, _Cols, RawUsernames} = epgsql:squery(Conn, "select username from users"),
    Usernames = lists:map(fun({Username}) -> Username end, RawUsernames),
    {reply, Usernames, State};

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(Cast, State) ->
    logger:warning("Unexpected cast ~p", [Cast]),
    {noreply, State}.

handle_info(Info, State) ->
    logger:warning("Unexpected message ~p", [Info]),
    {noreply, State}.

terminate(Reason, _State) ->
    logger:error("Unexpected termination ~p", [Reason]),
    ok.
