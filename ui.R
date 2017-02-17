shinyUI(bootstrapPage(
  
  shinyjs::useShinyjs(),
  
  navbarPage("Statistics Practice", inverse=TRUE),
  

  fluidRow(
    column(2),
    column(8,
      #titlePanel("Statistics Practice"),
      uiOutput("test"),

      uiOutput("problemText"),
      uiOutput("problem"),
      uiOutput("answer"),

      uiOutput("placeholder"),
      uiOutput("idDiv"),
      #actionButton("submit", "Submit"),
      #actionButton("nextProb", "Next Problem"),

      div(style="height:20px;"),
      uiOutput("feedback"),
      uiOutput("progressBar")

    ),
    column(2)
    )

))
