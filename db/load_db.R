# create DB for dynamic testing environment
require(RSQLite)
require(DBI)

# instantiate db
db = dbConnect(SQLite(), dbname="results.sqlite")

# create table if it doesn't exist
if (dbExecute(db, "SELECT name FROM sqlite_master WHERE type='table' AND name='results'") == 1) {
  dbSendQuery(db,
              "CREATE TABLE results
              (date INT,
              id TEXT,
              correct INT,
              method TEXT,
              answer TEXT,
              solution TEXT")
}

# loading posix time
# as.POSIXct(date, origin="1970-01-01")