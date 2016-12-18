source('meantest.R')
source('mediantest.R')
source('mintest.R')

shinyServer(function(input, output) {

    observeEvent(input$nextProb, {

      # sample from available types
      pset = sample(c("mean","median","min"), size=1, replace=T)
      problem = switch(pset,
        "mean" = meanTest(),
        "median" = medianTest(),
        "min" = minTest()
        )

      output$problemText = renderUI(p(problem$text))
      output$problem = renderUI(p(problem$problemDisp))
      output$answer = renderUI(
        switch(problem$input,
          "numeric" = numericInput("answer", "Answer", value=""),
          "text" = textInput("answer", "Answer", value=""))
      )

      # when submit clicked, check answer
      observeEvent(input$submit, {
        # get answer
        answer = isolate(input$answer)

        output$check = renderUI({
          if (answer == problem$solution) {
            p("Correct")
          } else {
            p("Incorrect")
          }
        })
        })

      })

    # # clear the space
    # output$check = renderUI({
    #   br()
    #   })
    #
    # # wait for next button click
    # observeEvent(input$nextProb, {
    #
    #   # clear answer
    #   output$check = renderUI({
    #     br("")
    #     })
    #
    #   test = sample(c("mean"), size=1, replace=T)
    #
    #   switch(test,
    #          "mean" = meanTest(input, output),
    #          "median" = medianTest(input, output)
    #          )
    #   })
})
