anova.p = function(){
  
  # generate random t-values, degrees of freedom, and pull prob
  fval = round(runif(1, 0, 16), 2)
  df1 = sample(c(1:4), size=1, replace=T) # numerator df
  df2 = sample(c(10,20,40,60,120,200), size=1, replace=T) # denominator df
  fprob = round(pf(fval, df1, df2, lower.tail = FALSE), 4)
  
  # text for the problem
  probText = "Would you reject or fail to reject the null hypothesis of the following test?"
  probMath = wellPanel(HTML(
    paste(c("F =", fval, "<br>df =", paste(df1, df2, sep=", "), 
            ifelse(fprob != 0, paste("<br>p =", fprob, sep=" "), "<br>p < .01")), 
            collapse=" ")))
  
  # solution space
  probMathDisp = probMath
  probSolution = ifelse(fprob < .05, "Reject the null hypothesis",
                        "Fail to reject the null hypothesis")
  probChoices = c("Reject the null hypothesis",
                  "Fail to reject the null hypothesis",
                  "There is not enough information to make a decision")
  
  # feedback
  feedback = ifelse(fprob < .05,
                    "If the probability (<i>p</i>) is less than .05, we can <strong>reject the null hypothesis</strong> that the means of two sets of data are equal.",
                    "If the probability (<i>p</i>) is greater than .05, we <strong>fail to reject the null hypothesis</strong> that the means of two sets of data are equal.")
  
  # return the following
  return(list(
    "method" = "Basic F-test p-value interpretation",
    "text" = probText,
    "problem" = probMath,
    "problemDisp" = probMathDisp,
    "solution" = probSolution,
    "input" = "multichoice",
    "choices" = probChoices,
    "feedback" = feedback
  ))
}
