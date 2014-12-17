## ui.R for Capstone app

shinyUI(navbarPage(
    titlePanel("JHU DSS Capstone Word Prediction App"),
    ##sidebarLayout(,
    tabsetPanel(type="tabs",
                tabPanel("Instructions",
                         h4("Welcome to my Johns Hopkins University Data Science Specialization Capstone Project App!"),
                         p("In this app you will choose a source of text, 
                           either Twitter or a news article. Then you will type, 
                           not copy-and-paste*, all but the last word of one sentence from 
                           the chosen source. Then click the 'submit' button.
                           The app will predict which word is most likely to finish
                           the sentence. Depending on how many word choices you elected to 
receive, it will suggest up to four alternatives to the most likely word. However, it won't do squat 
                           until you agree to the guidelines about pasting and punctuation."),
                         br(),
                         p("The entered text may contain commas (,) and/or periods (.).
Words with apostrophes (') should
                           be entered without the apostrophe. For example, please enter didnt 
                           instead of didn't. Please do not enter any other type of 
                           punctuation or special characters"),
                         br(),
                    p("The reason you may not paste into the text window is that frequently
                      online sources contain characters that appear to be 
                      'normal Latin-1 fonts', but that 
                      R reads as something else. For example, during my exploratory analysis phase,
                      I found that the phrase 'of course' was the most common one, but there
                      were eight instances of 'of course' that table() listed separately. 
                      Therefore, to avoid this type of error, I request that you only type
                      in your text."),
                    br(),
                    p("In summary:"),
                    p("* Please enter feed from the feed you tell the app you are using. 
                      (In other words, if you click Twitter, then enter text from Twitter.)"),
                    p("* Please enter only one sentence at a time."),
                    p("* If you don't get the word you expected, please check your spelling."),
                    p("*** If you select to have more than one word returned, please do not mark
                      that against the 'returns one word' portion of the grading rubric - this is an 
                      added benefit, which is how some existing commercial texting software works."),
                    br(),
                    p("For more information about the code or statististics on this data, please see my 
                      github repo: https://github.com/LRG2000/CapstoneProject/tree/master/repos")
                ),
                tabPanel("Prediction",
                     sidebarPanel(
                         ## enter something that tells user to choose type of input, then click "load" or something
                         radioButtons("feed", label="Input type", choices = list( "News" = 1, "Twitter" = 2),
                                      select = 1),
                         numericInput("nwords", 
                                      label="Number of word choices you would like to see (1-5)",
                                      value = 1, min = 1, max = 5, step = 1)),
                     mainPanel(
                         p("I will not paste text into the text field. I will not use
                         a sentence that has punctuation other than period (.), comma (,), exclamation mark (!) or question marks (?)."),
                         checkboxInput("agree", label = "I agree", value=FALSE),
                         textInput("text", label = "Input text:", value=""),
                            tags$head(tags$style(type="text/css", "#text {width:450px}")),
        ## apropriate label is either "loading, please wait (zzz...)" or "Enter your text and click "submit"
                    
                    submitButton("submit"),
                    p(" "),
                    htmlOutput("prediction")
        ))
    )
    
    ))