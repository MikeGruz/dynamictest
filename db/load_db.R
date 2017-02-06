# create DB for dynamic testing environment
require(RSQLite)
require(DBI)

# instantiate db
db = dbConnect(SQLite(), dbname="data/results.sqlite")

# create table if it doesn't exist
if (dbExecute(db, "SELECT name FROM sqlite_master WHERE type='table' AND name='results'") == 1) {
  dbSendQuery(db,
              "CREATE TABLE results
              (id INTEGER PRIMARY KEY, -- Autoincrement
              user_id TEXT,
              date INTEGER,
              correct INTEGER,
              method TEXT,
              answer TEXT,
              solution TEXT)")
}

# loading posix time
# as.POSIXct(date, origin="1970-01-01")
