-module(live_coding_one).

-export([is_odd/1]).

is_odd(Number) ->
    Number rem 2 == 1.

