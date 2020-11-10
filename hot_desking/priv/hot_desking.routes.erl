#{prefix => "",
  security => false,
  routes => [
            {"/", { hot_desking_main_controller, index}, #{methods => [get]}}
           ],
 statics => [
             {"/assets/[...]", "assets"}
            ]
}.
