# Second classes live coding script

Let's start with creating a new nova project:
```
$ rebar3 new nova hot_desking
$ cd hot_desking
```

Since this is not a HTML course I am just copy-pasting prepared HTML and JS code to `hot_desking/src/views/hot_desking_main.dtl` and `hot_desking/src/views/choose_user_and_date.dtl` files.

Let's now try running an application and see if it works in a browser:

```
$ rebar3 shell
```

now go to http://localhost:8080/ and see if the website works.

now go to `hot_desking/src/controllers/hot_desking_main_controller.erl` and replace existing `index/1` with this code:

```erlang
index(#{req := #{path := <<"/">>}}) ->
    {ok, [
        {message, "When would you like to visit the office?"},
        {main_view, "choose_date"},
        {qs, ""}
    ]}.
```

It provides parameters to be replaced with those in `{{params}}` from a respective view.
After you close a `rebar3 shell` and start it again and reload the page you should see a new message (later on I will refer to those 2 actions as *reloading the project*.

Now we need to implement a `/choose_user_and_date` endpoint to provide the content to the main part of this page.

To do that we need go to `hot_desking/priv/hot_desking.routes.erl` file and add a routing path:
```erlang
{"/choose_user_and_date", { choose_user_and_date_controller, index}, #{methods => [get]}}
```
And add a controller to handle the new request. Create a new file `src/controllers/choose_user_and_date_controller.erl` and add this code inside it to return `choose_user_and_date` view:

```erlang
-module(choose_user_and_date_controller).

-export([index/1]).

index(#{req := #{path := <<"/choose_user_and_date">>}}) ->
    {ok, []}.
```

`index/1` returns an empty list since this view is not parametrized.

After reloading a project you should see a form with a date to be picked but names picking does not work just yet.
It is because we need to implement an `/all_users` endpoint which will return a list of users.

As previously in `hot_desking/priv/hot_desking.routes.erl` add a route:
```erlang
{"/all_users", { choose_user_and_date_controller, index}, #{methods => [get]}}
```

and modify `index/1` in to handle the clause:
```erlang
index(#{req := #{path := <<"/choose_user_and_date">>}}) ->
    {ok, []};
index(#{req := #{path := <<"/all_users">>}}) ->
    Response = [<<"Aleksander">>, <<"Rick">>, <<"Morty">>],
    % TODO replace static Response list with the one taken from DB.
    {json, Response}.

```
file `src/controllers/choose_user_and_date_controller.erl`