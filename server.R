# source all functions in test folder
source("tests/regress.R")
source("tests/ttest.R")

shinyServer(function(input, output) {
  
  genProblem <- function() {
    pset <-  sample(c("reg"), size=1, replace=T)
    problem <-  switch(pset,
                       "mean" = meanTest(),
                       "median" = medianTest(),
                       "min" = minTest(),
                       "max" = maxTest(),
                       "multichoice" = multTest(),
                       "ttest" = tTest(),
                       "reg" = regTest()
    )
    return(problem)
      
  }
  
  # container for reactive problem set
  prob <- reactiveValues()
    
  # reset problem space on "next problem" click
  observeEvent(input$nextProb, {
    
    # get problem set
    prob$problem <- genProblem()
    
    # output problem to UI
    output$problemText <-  renderUI(p(prob$problem$text))
    output$problem <-  renderUI(p(prob$problem$problemDisp))
    output$answer <-  renderUI(
      switch(prob$problem$input,
             "numeric" = numericInput("answer", "Answer", value=""),
             "text" = textInput("answer", "Answer", value=""),
             "multichoice" = radioButtons("answer", "Answer",
                                          choices = prob$problem$choices,
                                          selected = character(0))
      )
    )
    
    # remove correct/incorrect text
    output$check <- renderUI({
      p(" ")
    })
    
  }, ignoreNULL = TRUE)
  
  # when submit clicked, check answer
  observeEvent(input$submit, {

    # isolate solution from reactive
    solution <- isolate(prob$problem$solution)
    
    output$check <- renderUI({
      if (input$answer == solution) {
        p("Correct")
      } else {
        p("Incorrect")
      }
    })

  })
  
    
})
      
    

      
    
      
        
      

  
