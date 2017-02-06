maxtest = function(){
  probText = "Find the maximum of the following set of numbers"
  probMath = round(rnorm(5, sample(0:5, 1), 1))
  probMathDisp = paste(probMath, collapse=" ")
  probSolution = max(probMath)
  return(list(
    "method" = "find maximum",
    "text" = probText,
    "problem" = probMath,
    "problemDisp" = probMathDisp,
    "solution" = probSolution,
    "input" = "numeric"
    ))
}
