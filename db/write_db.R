# function to write test results to file

writeTest <- function(db, user_id, correct, method, answer, solution) {
  outTable <- data.frame(
    user_id = user_id,
    date = Sys.time(),
    correct = correct,
    method = method,
    answer = answer,
    solution = solution
  )
  
  dbWriteTable(db, "results", outTable, append=TRUE)
}