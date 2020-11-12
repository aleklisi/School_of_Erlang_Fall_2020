-module(hot_desking_main_controller).
-export([
         index/1
        ]).

index(#{req := #{path := <<"/">>}}) ->
    {ok, [
        {message, "When would you like to visit the office?"},
        {main_view, "choose_date"},
        {query_string, ""}
    ]};
index(#{req := #{
    path := <<"/choose_desk">>,
    qs := BinQueryString}}) ->
    {ok, [
        {message, "Which desk would you like to work at?"},
        {main_view, "choose_desk"},
        {query_string, binary_to_list(BinQueryString)}
    ]}.
