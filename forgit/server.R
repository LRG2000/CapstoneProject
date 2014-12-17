## server.R for Capstone project

options(shiny.maxRequestSize = 7*1024^2)

shinyServer(function(input, output){
    ## when click submit, start the prediction function, and it should have as 1st line, 
    ##"predicting, please wait"
    
   
    output$prediction <- renderUI({ 
        if (input$agree) {
            if (as.numeric(input$feed) == 1) { ## if it's news
                outwords <- predictWord(input$text, biendnews, triendnews, ltabnews, 
                                      littlenews, input$nwords)
                outtxt <- paste0("The most likely word to complete your sentence is <em>", 
                                 outwords[1], "</em>.<br>")
                if (input$nwords > 1) {
                    for (i in 2:input$nwords){
                        outtxt <- paste0(outtxt,"<br>The next most likely word to complete your sentence is <em>",
                                     outwords[i], "</em>.")
                    }
                }
                HTML(outtxt)
                
                
                } else{
                    outwords <- predictWord(input$text, biendtwit, triendtwit, ltabtwit, 
                                          littletwit, input$nwords)
                    outtxt <- paste0("The most likely word to complete your sentence is <em>", 
                                     outwords[1], "</em>.<br>")
                    if (input$nwords > 1) {
                        for (i in 2:input$nwords){
                            outtxt <- paste0(outtxt,"<br>The next most likely word to complete your sentence is <em>",
                                             outwords[i], "</em>.")
                        }
                    }
                    HTML(outtxt)}
        } else{"You must agree to the guidelines for entering text before I can predict on your text."}
     
    })


})