-module(live_coding_one).

-export([
    is_odd/1,
    is_prime/1,
    gcd/2,
    are_coprime/2
]).

-export([
    duplicate/1,
    list_primesin_range/2
]).

is_odd(Number) ->
    Number rem 2 == 1.

is_prime(0) -> false;
is_prime(1) -> false;
is_prime(2) -> true;
is_prime(3) -> true;
is_prime(4) -> false;
is_prime(Number) ->
    % PossibleDividers = lists:seq(2, Number - 1),
    PossibleDividers = lists:seq(2, round(math:sqrt(Number)) + 1),
    is_prime(Number, PossibleDividers).

% is_prime(Number, PossibleDividers) when PossibleDividers == [] -> true;
is_prime(_Number, []) -> true;
is_prime(Number, [PossibleDivider | RemainingDividers]) ->
    case Number rem PossibleDivider of
        0 -> false;
        _ -> is_prime(Number, RemainingDividers)
    end.

gcd(A, 0) -> A;
gcd(A, B) -> gcd(B, A rem B).

are_coprime(A, B) ->
    % case gcd(A, B) of
    %     1 -> true;
    %     _ -> false
    % end.
    gcd(A, B) == 1.

duplicate([]) -> [];
duplicate([H | T]) ->
    [H, H | duplicate(T)].

list_primesin_range(From, To) ->
    IntsFromRange = lists:seq(From, To),
    % lists:filter(fun is_prime/1, IntsFromRange).
    lists:filter(fun(Int) -> is_prime(Int) end, IntsFromRange).