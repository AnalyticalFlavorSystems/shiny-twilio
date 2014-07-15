shinyUI(bootstrapPage(
    div(class="message_test",
          div(class="center",
                      textInput("phone_number", label="", value="")),
          div(class="center",
                      HTML("<div class='center'>
                                       <button id='send_test_call' class='action-button btn btn-default '>
                                                   Send test Call</button>
                                                               </div>")
           )
      )


))
