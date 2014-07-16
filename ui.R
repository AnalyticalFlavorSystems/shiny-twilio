shinyUI(fluidPage(
          fluidRow(style="margin-top:80px;",
                   column(4,offset=4,
                div(class="message_test",
                      div(style="text-align:center;",
                          textInput("phone_number", label="Add Your Phone Number", value="")),
                      div(class="center",
                          HTML("<div style='text-align:center;'>
                               <button id='send_test_call' class='action-button btn btn-primary '>
                               Send test Call</button>
                               </div>")
                           )
                      )

                      )
                )

        )
)
