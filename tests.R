

# server function
meanTest = function(input, output, session) {
  observeEvent(input$nextProb, {

    # generate random vector
    x <<- round(rnorm(2, 4, 1))

    output$problem = renderUI({
          p(paste(x, collapse=' '))
        })

    output$answer = renderUI({
        numericInput("answer", "Answer", value="")
      })

    output$check = renderUI({
        br()
      })


      })

  observeEvent(input$submit, {

      # get answer
      answer = isolate(input$answer)

      output$check = renderUI({
        if (answer == mean(x)) {
          p("Correct")
        } else {
          p("Incorrect")
        }

        })
    })

}
