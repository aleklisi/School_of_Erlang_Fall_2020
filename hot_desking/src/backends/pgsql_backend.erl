%% See this as an inspiration https://github.com/spawnfest/eneo4j/blob/master/src/eneo4j_worker.erl

-module(pgsql_backend).

-behaviour(gen_server).

%% API
-export([start_link/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

start_link(Args = #{name := Name}) ->
    gen_server:start_link({local, Name}, ?MODULE, Args, []);
start_link(Args) ->
    gen_server:start_link(?MODULE, Args, []).

% TODO use Args to get to the connection
init(_Args) ->
    {ok, Conn} = epgsql:connect(#{
        host => "localhost",
        port => 5432,
        username => "postgres",
        password => "postgres",
        database => "hot_desking",
        timeout => 4000
    }),
    {ok, #{conn => Conn}}.

% check https://github.com/epgsql/epgsql#simple-query
handle_call(get_all_users, _From, State = #{conn := Conn}) ->
    {ok, _, RawUsers} = epgsql:squery(Conn, "select username from users"),
    Users = lists:map(fun({User}) -> User end, RawUsers),
    {reply, Users, State};
handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(Cast, State) ->
    logger:warning("Unexpected cast ~p", [Cast]),
    {noreply, State}.

handle_info(Info, State) ->
    logger:warning("Unexpected message ~p", [Info]),
    {noreply, State}.

terminate(Reason, _State) ->
    logger:error("~p", [Reason]),
    ok.
