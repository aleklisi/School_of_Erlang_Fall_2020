#{prefix => "",
  security => false,
  routes => [
            {"/", { hot_desking_main_controller, index}, #{methods => [get]}}

          , {"/choose_user_and_date", { choose_user_and_date_controller, index}, #{methods => [get]}}
          , {"/all_users", { choose_user_and_date_controller, index}, #{methods => [get]}}

           ],
 statics => [
             {"/assets/[...]", "assets"}
            ]
}.
