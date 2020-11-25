class: middle, center

# Tooling in Erlang

School of Erlang

---
# Erlang types

Erlang is a dynamically typed language.
Still, it comes with a notation for declaring sets of Erlang terms to form a particular type.

Defining types:

```erlang
-export_type([user_id/0]).

-type user_id() :: string().
-type desk_state() :: free | {taken, user_id()}.
```

Typing functions:
```erlang
-spec get_all_desks(calendar:date()) -> [{DeskId :: string(), desk_state()}].
get_all_desks(Date) ->
    [
        {"desk1", free},
        {"desk2", {taken, "krzys123"}}
    ].

```

[See the docs](https://erlang.org/doc/reference_manual/typespec.html)

---
# Erlang types

Live coding - adding types functions in `hot_desking/src/controllers/desks_map_controller.erl` file.

---
# Dialyzer

The dialyzer is a static analysis tool that identifies software discrepancies,
such as definite type errors, code that has become dead or unreachable because of a programming error,
and unnecessary tests, in single Erlang modules or entire (sets of) applications.

Dialyzer uses the Success Typings behind the scene,
a type checker for a language like Erlang should work without type declarations being there (although it accepts hints),
should be simple and readable,
should adapt to the language (and not the other way around), and only complain on type errors that would guarantee a crash.

[See the docs](http://erlang.org/doc/apps/dialyzer/dialyzer_chapter.html)

[See the book](https://learnyousomeerlang.com/dialyzer)

[Success typing paper](http://www.it.uu.se/research/group/hipe/papers/succ_types.pdf)

---
#  Dialyzer demo

```bash
$ rebar3 dialyzer
```

Success Typing - it only complains when it can prove you are wrong.

---
# Gradualizer

Gradualizer aims to integrate well into existing Erlang code bases in a non intrusive way. It does so by
 - having a type system that is based on the principles of Gradual Typing
 - using the existing type specs syntax in Erlang.
 - allowing for granular opt-in of type checking. Without any type specs, no static typing happens.

When type specs are added the program is checked against these specs statically.
The more type specs, the more static typing.

[See the gradual typing](https://en.wikipedia.org/wiki/Gradual_typing)
[See the project](https://github.com/josefs/Gradualizer)

---
# Gradualizer - adding to your project demo:

```erlang
{plugins,
    [
        {gradualizer, {git, "git://github.com/josefs/Gradualizer.git", {branch, "master"}}}
    ]
}.
```

```bash
$ rebar3 gradualizer
```

---
# Dialyzer vs Gradualizer

Gradualizer is faster than Dialyzer.

They use different types systems.

They are not interchangeable. Sometimes both see the error sometimes only one of them.

[See the description](https://github.com/josefs/Gradualizer/wiki/Comparison-to-Dialyzer)

---
# Erlang Edoc

[See the example in the code](https://github.com/spawnfest/eneo4j/blob/master/src/eneo4j.erl)

[and the results.](https://github.com/spawnfest/eneo4j/blob/master/src/eneo4j.erl)

---
# Common test

[ct templates](http://erlang.org/doc/apps/common_test/example_chapter.html)

[See the docs](https://erlang.org/doc/apps/common_test/basics_chapter.html)

# Common test
Live example

---
# Erlang tracing

 - https://github.com/chrzaszcz/erlang_doctor
 - https://github.com/ferd/recon
 - https://erlang.org/doc/man/dbg.html

`dbg:tracer(process, {fun dbg:dhandler/2, standard_io}).` vs `dbg:tracer().`

---
# Distributed Erlang

[See the docs](https://erlang.org/doc/reference_manual/distributed.html)

Application [failover](https://erlang.org/doc/design_principles/distributed_applications.html#failover) and [takeover](https://erlang.org/doc/design_principles/distributed_applications.html#takeover)

C Node does not have to be written in C. It may be written in eg [Python](https://github.com/Pyrlang/Pyrlang).
