regress = function(){

  # generate regression
  x = runif(100, -1, 1)
  y = 2 + runif(1, -1, 1)*x + rnorm(100, 0, 1)
  fit = lm(y~x)
  summary.fit = summary(fit)$coefficients
  x.coef = round(fit$coefficients[[2]], digits=3)
  int.coef = round(fit$coefficients[[1]], digits=3)

  # find a better way to do this
  pval = round(summary(fit)$coefficients[2,4], digits=5)

  summary.fit[,4] <- round(summary.fit[,4], digits=5)
  # text for the problem
  probText = "Interpret the slope coefficient of x"
  probMathDisp = renderPrint(summary.fit)

  # solution space - accounting for significance and directionality
  probSolution = ifelse(pval >= .05, "There is no significant effect of x on y.",
    ifelse(x.coef > 0,
      sprintf("For each 1-unit increase in x, y increases by %s", abs(x.coef)),
      sprintf("For each 1-unit increase in x, y decreases by %s", abs(x.coef))
  ))

  # choices
  probchoices = c(
     sprintf("For each 1-unit increase in x, y increases by %s", abs(x.coef)),
     sprintf("For each 1-unit increase in x, y decreases by %s", abs(x.coef)),
     sprintf("For each %s-unit increase in x, y increases by 1", abs(x.coef)),
     sprintf("For each %s-unit increase in x, y increases by %s", x.coef, int.coef),
     "There is no significant effect of x on y."
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
