-module(example_monitor).

-export([main/0]).

main() ->
    MonitoredPid = spawn(fun monitored_process/0),
    MonitoringPid = spawn(fun() -> monitoring_process(MonitoredPid) end),
    timer:sleep(2000),
    % https://erlang.org/doc/man/erlang.html#is_process_alive-1
    print({self, is_process_alive(self())}),
    print({monitored, is_process_alive(MonitoredPid)}),
    print({monitring, is_process_alive(MonitoringPid)}).

monitored_process() ->
    timer:sleep(1000),
    1 = 2, % This will never match
    ok.

monitoring_process(MonitoredPid) ->
    monitor(process, MonitoredPid),
    receive
        Msg ->
            print(Msg),
            timer:sleep(3000)

    after
        3000 ->
            print("No Msg!")
    end.

print(Term) ->
    io:fwrite("My Pid is ~p and I want to print: ~p\n", [self(), Term]).
