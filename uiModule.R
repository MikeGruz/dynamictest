# ui function
qSpaceUI = function(id) {

  ns = NS(id)

  tagList(
    uiOutput(ns("problem")),
    uiOutput(ns("answer")),
    uiOutput(ns("check")),

    actionButton(ns("submit"), "Submit"),
    actionButton(ns("nextProb"), "Next Problem")
  )
}
