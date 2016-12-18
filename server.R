source('meantest.R')
source('mediantest.R')
source('mintest.R')
source('multchoice.R')

shinyServer(function(input, output) {

    observeEvent(input$nextProb, {

      # sample from available types
      pset = sample(c("mean","median","min","multi"), size=1, replace=T)
      problem = switch(pset,
        "mean" = meanTest(),
        "median" = medianTest(),
        "min" = minTest(),
        "multi" = multTest()
        )

      output$problemText = renderUI(p(problem$text))
      output$problem = renderUI(p(problem$problemDisp))
      output$answer = renderUI(
        switch(problem$input,
          "numeric" = numericInput("answer", "Answer", value=""),
          "text" = textInput("answer", "Answer", value=""),
          "multi" = radioButtons("answer", "Answer",
                choices = problem$choices,
                selected = "")
          )
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


})
