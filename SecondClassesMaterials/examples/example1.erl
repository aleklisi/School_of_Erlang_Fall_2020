-module(example1).

-export([main/0]).

main() ->
    print_my_pid(),
    GivenPid = self(),
    spawn(fun() -> print_my_pid(), print_pid(GivenPid) end),
    print_my_pid().

print_my_pid() ->
    print_pid(self()).

print_pid(Pid) ->
    io:fwrite("~p is printing ~p\n", [self(), Pid]).