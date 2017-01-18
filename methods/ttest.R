ttest = function(){

  # generate random t-values, degrees of freedom, and pull prob
  tval = round(runif(1, -4, 4))
  df = sample(c(10,30,60,120,1000), size=1, replace=T)
  tprob = round(ifelse(tval < 0, pt(tval, df), pt(tval, df, lower.tail=F)), digits=3)

  # text for the problem
  probText = "Would you reject or fail to reject the null hypothesis of the following test?"
  probMath = wellPanel(paste(c("t =", tval, "df =", df, "p =", tprob), collapse=" "))

  # solution space
  probMathDisp = probMath
  probSolution = ifelse(tprob < .05, "Reject the null hypothesis",
                        "Fail to reject the null hypothesis")
  probChoices = c("Reject the null hypothesis",
                  "Fail to reject the null hypothesis",
                  "There is not enough information to make a decision")

  # feedback
  feedback = ifelse(tprob < .05,
    "If the probability (<i>p</i>) is less than .05, we can <strong>reject the null hypothesis</strong> that the means of two sets of data are equal.",
    "If the probability (<i>p</i>) is greater than .05, we <strong>fail to reject the null hypothesis</strong> that the means of two sets of data are equal.")

  # return the following
  return(list(
    "text" = probText,
    "problem" = probMath,
    "problemDisp" = probMathDisp,
    "solution" = probSolution,
    "input" = "multichoice",
    "choices" = probChoices,
    "feedback" = feedback
    ))
}
