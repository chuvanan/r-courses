## install.pacakges("DBI")
library(DBI)

path <- system.file("db", "datasets.sqlite", package = "RSQLite")
db <- dbConnect(RSQLite::SQLite(), path)

## list all tables
dbListTables(db)
str(dbGetQuery(db, "SELECT * FROM mtcars"))

## import table
dbReadTable(db, "mtcars")

## Polite to disconnect from db when done
dbDisconnect(db)
