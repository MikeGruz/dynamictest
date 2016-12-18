shinyUI(fluidPage(

  fluidRow(
    column(2),
    column(8,
      titlePanel("Statistics Practice"),

      uiOutput("problemText"),
      uiOutput("problem"),
      uiOutput("answer"),
      uiOutput("check"),

      actionButton("submit", "Submit"),
      actionButton("nextProb", "Next Problem")

    ),
    column(2)
    )

))
