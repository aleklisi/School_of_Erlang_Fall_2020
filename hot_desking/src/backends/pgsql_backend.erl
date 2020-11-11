-module(pgsql_backend).

-behaviour(gen_server).

%% API
-export([start_link/1]).
-export([init/1, handle_call/3, handle_cast/2, handle_info/2, terminate/2]).

start_link(Name) ->
    gen_server:start_link({local, Name}, ?MODULE, [], []).

init(Args) ->
    State = Args,
    {ok, State}.

handle_call(Call, _From, State) ->
    logger:warning("Unexpected call ~p", [Call]),
    {reply, Call, State}.

handle_cast(Cast, State) ->
    logger:warning("Unexpected cast ~p", [Cast]),
    {noreply, State}.

handle_info(Info, State) ->
    logger:warning("Unexpected message ~p", [Info]),
    {noreply, State}.

terminate(Reason, _State) ->
    logger:error("~p", [Reason]),
    ok.
