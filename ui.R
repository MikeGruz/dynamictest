shinyUI(fluidPage(

  fluidRow(
    column(2),
    column(8,
      titlePanel("Statistics Practice"),

      uiOutput("problemText"),
      uiOutput("problem"),
      uiOutput("answer"),

      uiOutput("placeholder"),
      actionButton("submit", "Submit"),
      actionButton("nextProb", "Next Problem"),
      
      uiOutput("check")

    ),
    column(2)
    )

))
