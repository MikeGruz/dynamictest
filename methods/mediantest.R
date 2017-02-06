mediantest = function(){
  probText = "Find the median of the following set of numbers"
  probMath = round(rnorm(5, sample(0:5, 1), 1))
  probMathDisp = paste(probMath, collapse=" ")
  probSolution = median(probMath)
  return(list(
    "method" = "compute median",
    "text" = probText,
    "problem" = probMath,
    "problemDisp" = probMathDisp,
    "solution" = probSolution,
    "input" = "numeric"
    ))
}
