# function to write test results to file
writeTest <- function(db, id, result, method, answer, solution) {
  outTable <- data.frame(
    id = id,
    date = Sys.time(),
    result = result,
    method = method,
    answer = answer,
    solution = solution
  )
  
  dbWriteTable(db, "results", outTable, append=TRUE)
}