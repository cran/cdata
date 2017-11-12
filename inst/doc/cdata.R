## ----ex1-----------------------------------------------------------------
library("cdata")
my_db <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")

# pivot example
d <- data.frame(meas = c('AUC', 'R2'), val = c(0.6, 0.2))
DBI::dbWriteTable(my_db,
                  'd',
                  d,
                  temporary = TRUE)
qlook(my_db, 'd')

cT <- buildPivotControlTableN('d',
                              columnToTakeKeysFrom= 'meas',
                              columnToTakeValuesFrom= 'val',
                              my_db = my_db)
tab <- moveValuesToColumnsN('d',
                            keyColumns = NULL,
                            controlTable = cT,
                            my_db = my_db)
qlook(my_db, tab)

DBI::dbDisconnect(my_db)

