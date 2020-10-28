-module(live_coding_one_test).

-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").

one_is_odd_test() ->
    ?assert(live_coding_one:is_odd(1)).

two_is_not_odd_test() ->
    ?assertEqual(false, live_coding_one:is_odd(2)).

more_odd_numbers_test() ->
    ?assert(live_coding_one:is_odd(3)),
    ?assert(live_coding_one:is_odd(7)),
    ?assert(live_coding_one:is_odd(15)),
    ?assert(live_coding_one:is_odd(21)).

more_odd_not_numbers_test() ->
    ?assert(false == live_coding_one:is_odd(4)),
    ?assert(false == live_coding_one:is_odd(8)),
    ?assert(false == live_coding_one:is_odd(16)),
    ?assert(false == live_coding_one:is_odd(24)).


exactly_one_odd_it_N_and_N_plus_one_pair(true, false) -> true;
exactly_one_odd_it_N_and_N_plus_one_pair(false, true) -> true;
exactly_one_odd_it_N_and_N_plus_one_pair(_, _) -> false.

prop_exactly_one_odd_it_N_and_N_plus_one_pair() ->
    ?FORALL(N,
        non_neg_integer(),
        exactly_one_odd_it_N_and_N_plus_one_pair(
            live_coding_one:is_odd(N),
            live_coding_one:is_odd(N+1)
        )
    ).

exactly_one_odd_test() ->
    ?assert(
        proper:quickcheck(prop_exactly_one_odd_it_N_and_N_plus_one_pair(), 1000)
    ).


is_prime_some_numers_test() ->
    ?assertEqual(true, live_coding_one:is_prime(2)),
    ?assertEqual(true, live_coding_one:is_prime(3)),
    ?assertEqual(true, live_coding_one:is_prime(5)),
    ?assertEqual(true, live_coding_one:is_prime(7)),
    ?assertEqual(true, live_coding_one:is_prime(11)),
    ?assertEqual(false, live_coding_one:is_prime(4)).
