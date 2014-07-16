require(XML)
require(RCurl)

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
                        message <- paste("Greetings, it is currently, ",time,".  This message can be made to say anything.")

                        ## Now we build the XML file.
                        xml_message <- newXMLNode("Response")
                        newXMLNode("Say", message, attrs=c(voice='alice',
                                                           language='en-gb', loop=3), parent=xml_message)

                        ## Save the file temporarily
                        ## We name the file based on the date and username
                        filename <- paste0(Sys.Date(), "_", gsub(" ", "_", username(), ".xml"))
                        f <- tempfile()

                        saveXML(xml_message, file=f,
                                prefix="<?xml version='1.0' encoding='UTF-8' ?>")
                        
                        ## Now we upload it to a server or other accessible area.
                        ftpUpload(f, paste0("ftp://<your-ftp-server-name->",filename))

                        ## Twilio RCurl Rest Call 
                        POST('https://api.twilio.com/2010-04-01/Accounts/<Your-Twilio-account-id>/Calls.json',
                             body = list(Url=paste0("https://<your-ftp-server-name>",filename),
                                         From='+<Your-twilio-phone-number>',To=paste0("+1",isolate(input$phone_number))),
                             config=authenticate("<Your-Twilio-account-id>",
                                                 "<Your-Twilio-account-auth-token>",type="basic"))
                    }
                }
            })
})
