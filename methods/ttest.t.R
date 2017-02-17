ttest.t = function(){

  # generate random t-values, degrees of freedom, and pull prob
  tval = round(runif(1, -4, 4), 2)
  df = sample(c(10,30,60,120,1000), size=1, replace=T)
  tcrit = round(qt(.025, df), 2) # negative t-crit

  # text for the problem
  probText = "Would you reject or fail to reject the null hypothesis of the following two-tail t-test?"
  probMath = wellPanel(paste(c("t =", tval, "   df =", df, "   t critical =", tcrit, ",", abs(tcrit)), collapse=" "))

  # solution space
  probMathDisp = probMath
  probSolution = ifelse(abs(tval) > abs(tcrit), "Reject the null hypothesis",
                        "Fail to reject the null hypothesis")
  probChoices = c("Reject the null hypothesis",
                  "Fail to reject the null hypothesis",
                  "There is not enough information to make a decision")

  # feedback
  feedback = ifelse(abs(tval) > abs(tcrit),
    sprintf("If the our t-value (%s) is less than the lower-tail critical <i>t</i> %s, 
            or if it is greater than the upper-tail critical <i>t</i> %s, 
            we can <strong>reject the null hypothesis</strong> that the means of two sets 
            of data are equal.", tval, tcrit, abs(tcrit)),
    sprintf("If our t-value (%s) is greater than the lower-tail critical <i>t</i> %s <strong>and</strong> 
    less than the upper-tail critical <i>t</i> %s, we <strong>fail to reject the null 
    hypothesis</strong> that the means of two sets of data are equal.", tval, tcrit, abs(tcrit)))

  # return the following
  return(list(
    "method" = "Basic t-test critical t interpretation",
    "text" = probText,
    "problem" = probMath,
    "problemDisp" = probMathDisp,
    "solution" = probSolution,
    "input" = "multichoice",
    "choices" = probChoices,
    "feedback" = feedback
    ))
}
