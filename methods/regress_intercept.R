regress_intercept = function(){

  # generate regression
  x = runif(100, -1, 1)
  y = runif(1, -1, 1) + runif(1, -1, 1)*x + rnorm(100, 0, 1)
  fit = lm(y~x)
  summary.fit = summary(fit)$coefficients
  x.coef = round(fit$coefficients[[2]], digits=3)
  int.coef = round(fit$coefficients[[1]], digits=3)

  # find a better way to do this
  pval = round(summary(fit)$coefficients[2,4], digits=5)

  summary.fit[,4] <- round(summary.fit[,4], digits=5)
  # text for the problem
  probText = "Interpret the <strong>intercept of y.</strong>"
  probMathDisp = renderPrint(summary.fit)

  # solution space
  probSolution = sprintf("The mean of y after controlling for x is %s", int.coef)

  # choices
  probchoices = c(
     sprintf("The mean of y after controlling for x is %s", int.coef),
     sprintf("The mean of y after controlling for x is %s", x.coef),
     sprintf("For each 1-unit increase in x, y increases by %s", int.coef),
     "The intercept is not significantly different from 0, and cannot be interpreted"
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
