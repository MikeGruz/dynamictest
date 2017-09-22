meantest = function(){
  
  # problem text
  probText = "Find the mean of the following set of numbers (round to two decimal places)."
  
  # generate the set of numbers
  probMath = round(rnorm(sample(3:7, size = 1), sample(0:5, 1), 1))
  
  # display the set
  probMathDisp = paste(probMath, collapse=" ")
  
  # the solution
  probSolution = round(mean(probMath), digits = 2)
  
  # feedback
  feedback <- paste(
    "The correct answer is <i>",
    probSolution,
    "</i>. ",
    "We calculate the mean by first adding up all of the values in the set (",
    sum(probMath),
    ") and dividing by the total number of observations in the set (",
    length(probMath),
    ").",
    sep = ""
  )
  
  return(list(
    "method" = "compute mean",
    "text" = probText,
    "problem" = probMath,
    "problemDisp" = probMathDisp,
    "solution" = probSolution,
    "input" = "numeric",
    "feedback" = feedback
    ))
}
