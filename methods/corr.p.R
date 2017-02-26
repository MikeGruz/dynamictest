corr.p = function(){
  
  # generate random pearson's r value
  rval = round(runif(1, -.7, .7), 3)
  df = sample(10:100, size=1, replace=T)
  tval = (rval*sqrt(df))/sqrt(1-rval^2)
  rprob = round((pt(abs(tval), df, lower.tail=FALSE)*2), 4)
  
  # text for the problem
  probText = "Given the <i>Pearson's r</i> correlation value for <i>x</i> and <i>y</i>, 
              what is the relationship between the two variables?"
  
  probMath = wellPanel(HTML(
    paste(c("r =", rval, "<br>df =", df, 
            ifelse(rprob != 0, paste("<br>p =", rprob, sep=" "), "<br>p < .01")), 
          collapse=" ")))
  
  # solution space
  probMathDisp = probMath
  probSolution = ifelse(rprob < .05 & rval > 0, "There is a positive and significant relationship between x and y.",
                        ifelse(rprob < .05 & rval < 0, "There is a negative and significant relationship between x and y.",
                               "There is no significant relationship between x and y."))
  probChoices = c("There is a positive and significant relationship between x and y.",
                  "There is a negative and significant relationship between x and y.",
                  "There is no significant relationship between x and y.")
  
  # feedback
  feedback = ifelse(rprob < .05 & rval > 0,
                    "If the probability (<i>p</i>) is less than .05 and <i>r</i> is positive, we can state that there is a positive and significant relationship between x and y.",
             ifelse(rprob < .05 & rval < 0,
                    "If the probability (<i>p</i>) is less than .05 and <i>r</i> is negative, we can state that there is a negative and significant relationship between x and y.",
                    "If <i>p</i> is greater than .05, we cannot conclude that there is a relationship between x and y."))
  
  # return the following
  return(list(
    "method" = "Basic Pearson's r p-value interpretation",
    "text" = probText,
    "problem" = probMath,
    "problemDisp" = probMathDisp,
    "solution" = probSolution,
    "input" = "multichoice",
    "choices" = probChoices,
    "feedback" = feedback
  ))
}
