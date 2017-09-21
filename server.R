# to use: connect to Shiny Server with base url + '/?method=[method],[method],[method]' etc
require(shinyjs)

# source database connection files
source("db/load_db.R")
source("db/write_db.R")

# progressUpdate <- function(value=0, init=FALSE) {
#   if (init) {
#     return(
#       div("0/10", style="height:30px;width:1px;background-color:#6fa5fc;")
#     )
#   } else {
#     return(
#       div(sprintf("%d/10", value), 
#           style=sprintf("height:30px;width:%s%s;background-color:#6fa5fc;", value*10, "%"))
#     )
#   }
# }


shinyServer(function(input, output, session) {

  # set up reactive container for URI parameters
  paramList <- reactiveValues()
  
  # setup iteration counter
  # paramList$iter <- 0

  # pull testing parameters
  observe({
    # get query string
    query <- parseQueryString(session$clientData$url_search)

    # check for id boolean in query string
    if (!is.null(query[['id']])) {
      
      # if id is true, create id login
      if (query$id == "True") {
        
        # add UIs for id input
        insertUI(selector="#idDiv",
                 where="beforeEnd",
                 ui=p(id="idText", "Please enter your APSU email address:"))
        insertUI(selector="#idDiv",
                 where="beforeEnd",
                 ui=textInput("id", "", ""))
        insertUI(selector="#idDiv",
                 where="beforeEnd",
                 ui=actionButton("idSubmit", "Submit"))
        
        # get id on submit
        observeEvent(input$idSubmit, {
          paramList$id <- input$id
          
          # remove ID div
          removeUI(selector="#idDiv")
          
          # instantiate submit and nextProb buttons
          insertUI(selector="#placeholder",
                   where="afterEnd",
                   ui=actionButton("submit", "Submit"))
          insertUI(selector="#submit",
                   where="afterEnd",
                   ui=actionButton("nextProb", "Next Problem"))
          
        })
        
        
      } else {
        # null id if not true
        paramList$id <- NA
      }
    } else {
      # null ID if not present in URI
      paramList$id <- NA
      
      # instantiate submit and nextProb buttons
      insertUI(selector="#placeholder",
               where="afterEnd",
               ui=actionButton("submit", "Submit"))
      insertUI(selector="#submit",
               where="afterEnd",
               ui=actionButton("nextProb", "Next Problem"))
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
    
    # check for assignment identifier
    if (!is.null(query[['assign']])) {
      
      # assign assignment identifier
      paramList$assign <- query$assign
    } else {
      paramList$assign <- 0
    }
    
    # get number of trials param
    if (!is.null(query[['trials']])) {
      # check if numeric
      if (!is.na(as.numeric(query$trials))) {
        paramList$trials <- as.numeric(query$trials)
        
        paramList$correct <- 0
        
        # instantiate counter
        output$progress <- renderUI(
          p(
            paste("0/", paramList$trials, " Correct", sep="")
            )
          )
      }
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
    
    # enable submit button and answer input
    shinyjs::enable("submit")
    shinyjs::enable("answer")
    
    # disable next button
    shinyjs::disable("nextProb")
    
    # get problem set
    prob$problem <- genProblem()

    # output problem to UI
    output$problemText <-  renderUI(h4(HTML(prob$problem$text)))
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

    # enable next answer button
    shinyjs::enable("nextProb")
    
    # disable submit button and answer input
    shinyjs::disable("submit")
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
    
    # output$progressBar <- renderUI({
    #   
    #   if (input$answer == solution) {
    #     # move counter up if not over 10
    #     if (paramList$iter + 1 <= 10) {
    #       paramList$iter <- isolate(paramList$iter) + 1
    #     }
    #   } else {
    #     paramList$iter <- isolate(paramList$iter) - 1
    #   }
    #   
    #   output$progressBar <- renderUI(progressUpdate(value = paramList$iter))
    # })
    
    # save the result
    if (input$answer == solution) {
      writeTest(db=db, user_id=paramList$id, assign=paramList$assign, correct=1, method=prob$problem$method ,answer=input$answer, solution=solution)
      
      # update correct counter
      paramList$correct <- paramList$correct + 1
      output$progress <- renderUI(
        p(
          paste(paramList$correct,
                "/",
                paramList$trials,
                " Correct", sep = "")
        )
      )
      
    } else {
      writeTest(db=db, user_id=paramList$id, assign=paramList$assign, correct=0, method=prob$problem$method, answer=input$answer, solution=solution)
    }


    })

  })

