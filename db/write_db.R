# function to write test results to file
writeTest <- function(db, id, correct, method, answer, solution) {
  outTable <- data.frame(
    id = id,
    date = Sys.time(),
    correct = correct,
    method = method,
    answer = answer,
    solution = solution
  )
  
  dbWriteTable(db, "results", outTable, append=TRUE)
}