anova.f = function(){
  
  # generate random t-values, degrees of freedom, and pull prob
  fval = round(runif(1, 0, 12), 2)
  df1 = sample(1:4, size=1, replace=T)
  df2 = sample(c(10,30,60,120,1000), size=1, replace=T)
  df = paste(df1, df2, sep=", ")
  fcrit = round(qf(.05, df1, df2, lower.tail=FALSE), 2) # negative t-crit
  
  # text for the problem
  probText = "Would you reject or fail to reject the null hypothesis of the following F-test after analysis of variance (ANOVA)?"
  probMath = wellPanel(HTML(
    paste(c("F =", fval, "<br>df =", df, "<br>F critical =", fcrit), collapse=" ")))
  
  # solution space
  probMathDisp = probMath
  probSolution = ifelse(fval > fcrit, "Reject the null hypothesis",
                        "Fail to reject the null hypothesis")
  probChoices = c("Reject the null hypothesis",
                  "Fail to reject the null hypothesis",
                  "There is not enough information to make a decision")
  
  # feedback
  feedback = ifelse(fval > fcrit,
                    sprintf("If the our F-value (%s) is greater than the critical <i>F</i> %s, 
                            we can <strong>reject the null hypothesis</strong> that the means of the data 
                            are equal.", fval, fcrit),
                    sprintf("If our F-value (%s) is greater than the critical <i>F</i> %s, 
                            we <strong>fail to reject the null 
                            hypothesis</strong> that the means of the data are equal.", fval, fcrit))
  
  # return the following
  return(list(
    "method" = "Basic F-test critical F interpretation",
    "text" = probText,
    "problem" = probMath,
    "problemDisp" = probMathDisp,
    "solution" = probSolution,
    "input" = "multichoice",
    "choices" = probChoices,
    "feedback" = feedback
  ))
}
