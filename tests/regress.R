regTest = function(){

  # generate regression
  x = runif(100, 2, 4)
  y = 2 + runif(1, -2, 2)*x + rnorm(100, 0, 1)
  fit = lm(y~x)
  x.coef = round(fit$coefficients[[2]], digits=3)
  int.coef = round(fit$coefficients[[1]], digits=3)

  # text for the problem
  probText = "Interpret the slope coefficient of x"
  probMathDisp = renderPrint(summary(fit))

  # solution space
  probSolution = sprintf("For each 1-unit increase in x, y increases by %f", x.coef)

  # choices
  probchoices = c(
     sprintf("For each 1-unit increase in x, y increases by %f", x.coef),
     sprintf("For each 1-unit increase in x, y increases by %f", int.coef),
     sprintf("For each %s-unit increase in x, y increases by 1", x.coef),
     sprintf("For each %s-unit increase in x, y increases by %s", x.coef, int.coef)
    )

  # return the following
  return(list(
    "text" = probText,
    "problemDisp" = probMathDisp,
    "solution" = probSolution,
    "input" = "multichoice",
    "choices" = probchoices
    ))
}
