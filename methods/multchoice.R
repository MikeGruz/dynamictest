multchoice = function(){
  probText = "What is the median of the following set?"
  probMath = round(rnorm(7, sample(0:5, 1), 1))
  probMathDisp = paste(probMath, collapse=" ")
  probSolution = median(probMath)
  probChoices = c(probSolution, unique(probMath[!(probMath %in% probSolution)]))
  return(list(
    "text" = probText,
    "problem" = probMath,
    "problemDisp" = probMathDisp,
    "solution" = probSolution,
    "input" = "multichoice",
    "choices" = probChoices
    ))
}
