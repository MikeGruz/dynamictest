prob.num = function(){
  
  # generate random set of numbers
  num.set <- sample(1:6, replace = T, size = sample(4:8, size = 1))
  
  # pull one number
  num.one <- sample(num.set, size = 1)
  
  # get probability of that number
  num.table <- table(num.set)
  
  # get number of chosen number
  num.nums <- num.table[names(num.table) == num.one]
  
  # solution
  probSolution = round(num.nums / sum(num.table), digits = 2)
  
  # text for the problem
  probText = paste("What is the probability of drawing a",
                   num.one,
                   "from this set of numbers? (Round to two decimal places)")
  probMath = wellPanel(HTML(
    paste(num.set, collapse = " ")
  ))
  
  # solution space
  probMathDisp = probMath
  
  # feedback
  feedback <- paste(
    "The correct answer is <i>",
    probSolution,
    "</i>. ",
    "We calculate the probability of drawing a <i>",
    num.one,
    "</i> by taking the number of instances of <i>",
    num.one,
    "</i> (",
    num.nums,
    ") and dividing that by the total number in the set (",
    length(num.set),
    ").",
  sep = "")

  # return the following
  return(list(
    "method" = "Probability calculation",
    "text" = probText,
    "problem" = probMath,
    "problemDisp" = probMathDisp,
    "solution" = probSolution,
    "input" = "numeric",
    "feedback" = feedback
  ))
}
