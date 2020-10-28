-module(live_coding_one_test).

-include_lib("proper/include/proper.hrl").
-include_lib("eunit/include/eunit.hrl").

-import(live_coding_one, [list_primesin_range/2]).

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

gcd_test() ->
    ?assertEqual(2, live_coding_one:gcd(2, 4)),
    ?assertEqual(2, live_coding_one:gcd(6, 4)),
    ?assertEqual(1, live_coding_one:gcd(12, 11)).

are_coprime_test() ->
    ?assert(not live_coding_one:are_coprime(65, 35)),
    ?assert(live_coding_one:are_coprime(64, 35)).

duplicate_test() ->
    ?assert([] == live_coding_one:duplicate([])),
    ?assertEqual([1, 1], live_coding_one:duplicate([1])),
    ?assertEqual([1, 1, a, a], live_coding_one:duplicate([1, a])).

list_primesin_range_test() ->
    Expected = [7, 11, 13, 17, 19, 23, 29, 31],
    Actual = list_primesin_range(7, 31),
    ?assertEqual(Expected, Actual).

list_primesin_range_small_test() ->
    Expected = [2, 3, 5, 7, 11, 13],
    Actual = list_primesin_range(1, 14),
    ?assertEqual(Expected, Actual).

encode_run_len_empty_list_test() ->
    ?assertEqual([], live_coding_one:encode([])).

encode_run_len_one_element_list_test() ->
    ?assertEqual([{a, 1}], live_coding_one:encode([a])),
    ?assertEqual([{a, 2}], live_coding_one:encode([a, a])),
    ?assertEqual([{a, 1}, {b, 1}], live_coding_one:encode([a, b])),
    ?assertEqual([{a, 1}, {b, 1}], live_coding_one:encode([a, b])).

encode_run_len_test() ->
    Expected = [{a, 4}, {b, 1}, {c, 2}, {a, 2}, {d, 1}, {e, 4}],
    Actual = live_coding_one:encode([a, a, a, a, b, c, c, a, a, d, e, e, e, e]),
    ?assertEqual(Expected, Actual).

encode_modified_test() ->
    Actual = live_coding_one:encode_modified([a, a, a, a, b, c, c, a, a, d, e, e, e, e]),
    Expected = [{a, 4}, b, {c, 2}, {a, 2}, d, {e, 4}],
    ?assertEqual(Expected, Actual).

