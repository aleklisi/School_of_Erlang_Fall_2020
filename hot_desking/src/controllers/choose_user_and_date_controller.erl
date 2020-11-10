-module(choose_user_and_date_controller).

-export([index/1]).

index(#{req := #{path := <<"/choose_user_and_date">>}}) ->
    {ok, []};
index(#{req := #{path := <<"/all_users">>}}) ->
    Response = [<<"Aleksander">>, <<"Rick">>, <<"Morty">>],
    % TODO replace static Response list with the one taken from DB.
    {json, Response}.
