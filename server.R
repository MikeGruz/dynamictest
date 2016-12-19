source('tests/meantest.R')
source('tests/mediantest.R')
source('tests/mintest.R')
source('tests/maxtest.R')
source('tests/multchoice.R')
source('tests/ttest.R')

shinyServer(function(input, output) {

    observeEvent(input$nextProb, {

      # sample from available types
      pset = sample(c("mean","median","min",
                      "max","multichoice","ttest"), size=1, replace=T)
      problem = switch(pset,
        "mean" = meanTest(),
        "median" = medianTest(),
        "min" = minTest(),
        "max" = maxTest(),
        "multichoice" = multTest(),
        "ttest" = tTest()
        )

      output$problemText = renderUI(p(problem$text))
      output$problem = renderUI(p(problem$problemDisp))
      output$answer = renderUI(
        switch(problem$input,
          "numeric" = numericInput("answer", "Answer", value=""),
          "text" = textInput("answer", "Answer", value=""),
          "multichoice" = radioButtons("answer", "Answer",
                choices = problem$choices,
                selected = ""),
          ""
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
