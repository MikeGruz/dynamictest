# to use: connect to Shiny Server with base url + '/?method=[method],[method],[method]' etc
require(shinyjs)

# source database connection files
source("db/load_db.R")
source("db/write_db.R")

shinyServer(function(input, output, session) {

  # set up reactive container for URI parameters
  paramList <- reactiveValues()

  # pull testing parameters
  observe({
    # get query string
    query <- parseQueryString(session$clientData$url_search)

    # check for id in query string
    if (!is.null(query[['id']])) {
      paramList$id <- query$id
    } else {
      # null ID number if not present in URI
      paramList$id <- -99
    }

    # check for methods parameters in query string
    if (!is.null(query[['method']])) {

      # parse uri for methods
      paramList$methods <- strsplit(unlist(query$method), split=",")

      # source the methods
      sapply(
        sapply(paramList$methods, function(x){
          paste("methods/", paste(x, '.R', sep=''), sep='')
        }), source
      )

    } else {
      # if no method listed, source all methods in methods folder
      allMethods <- list.files("methods/", pattern="*\\.R")
      sapply(
        sapply(allMethods, function(x) {
          paste("methods/", x, sep="")
        }), source
      )

      # remove file extension from filelist names
      paramList$methods <- sapply(allMethods, function(x) {sub(".R", "", x)})
    }
  })

  genProblem <- function() {
    # sample from URI methods
    problem <- do.call(sample(unlist(paramList$methods), 1), args=list())

    return(problem)
  }

  # container for reactive problem set
  prob <- reactiveValues()

  # reset problem space on "next problem" click
  observeEvent(input$nextProb, {
    
    # enable submit button
    shinyjs::enable("submit")
    
    # enable answer input
    shinyjs::enable("answer")
    
    # get problem set
    prob$problem <- genProblem()

    # output problem to UI
    output$problemText <-  renderUI(HTML(prob$problem$text))
    output$problem <-  renderUI(p(prob$problem$problemDisp))
    output$answer <-  renderUI(
      switch(prob$problem$input,
             "numeric" = numericInput("answer", "Answer", value=""),
             "text" = textInput("answer", "Answer", value=""),
             "multichoice" = radioButtons("answer", "Answer",
                                          width = "100%",
                                          choices = prob$problem$choices,
                                          selected = character(0))
      )
    )

    # remove correct/incorrect text
    output$feedback <- renderUI({
      p(" ")
    })

  }, ignoreNULL = TRUE)

  # when submit clicked, check answer
  observeEvent(input$submit, {

    # disable submit button
    shinyjs::disable("submit")
    
    # disable input
    shinyjs::disable("answer")
    
    # isolate solution from reactive
    solution <- isolate(prob$problem$solution)

    output$feedback <- renderUI({
      # correct answer
      if (input$answer == solution) {
        # give feedback if available
        if (!is.null(prob$problem$feedback)) {
          tagList(
            h4("Correct"),
            HTML(prob$problem$feedback)
          )
        } else {
          h4("Correct")
        }

      # wrong answer
      } else {
        # give feedback if available
        if (!is.null(prob$problem$feedback)) {
          tagList(
            h4("Incorrect"),
            HTML(prob$problem$feedback)
          )
        } else {
          h4("Incorrect")
        }

      }
    })
    
    # save the result - change to db solution later
    if (input$answer == solution) {
      writeTest(db=db, user_id=paramList$id, correct=1, method=prob$problem$method ,answer=input$answer, solution=solution)
    } else {
      writeTest(db=db, user_id=paramList$id, correct=0, method=prob$problem$method, answer=input$answer, solution=solution)
    }


    })

  })

