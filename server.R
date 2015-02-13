require(XML)
require(RCurl)
require(httr)
require(RTwilio)

shinyServer(function(input, output) {
            ## Username get
            username <- reactive({
                ## In Shiny Server, you can use 'session$user' 
                ## We just make it simple here for demo
                "evandev"
            })

            observe({
                if(!is.null(input$send_test_call)) {
                    if(!is.null(isolate(input$phone_number)) &&
                       isolate(input$phone_number) != "") {
                        time <- now()

                        ## We make the message
                        message <- paste("Greetings, it is currently, ",
                                         time,".  This message can be made to say anything.")

                        response <- twilio_stateless_call("<YOUR-ACCOUNT-ID",
                                                          "<YOUR-ACCOUNT-TOKEN>",
                                                          message=message,
                                                          From="<YOUR-TWILIO-PHONE-NUMBER>",
                                                          To=paste0("+1",
                                                                    isolate(input$phone_number)))

                        ## This will print response for testing purposes.
                        # print(response)
                    }
                }
            })
})
