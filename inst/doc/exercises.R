## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
# convert from this format
dadmomw <- wrapr::build_frame(
   "famid"  , "named", "incd", "namem", "incm" |
     1      , "Bill" , 30000 , "Bess" , 15000  |
     2      , "Art"  , 22000 , "Amy"  , 18000  |
     3      , "Paul" , 25000 , "Pat"  , 50000  )

# to this format
dadmomt <- wrapr::build_frame(
   "famid"  , "dadmom", "name", "inc" |
     1      , "d"     , "Bill", 30000 |
     1      , "m"     , "Bess", 15000 |
     2      , "d"     , "Art" , 22000 |
     2      , "m"     , "Amy" , 18000 |
     3      , "d"     , "Paul", 25000 |
     3      , "m"     , "Pat" , 50000 )

## ----echo=FALSE----------------------------------------------------------
knitr::kable(dadmomw[1, , drop=FALSE])

## ------------------------------------------------------------------------
library("cdata")

# identify the record key
recordKeys <- "famid"

# specify the outgoing record shape
outgoing_record <- wrapr::qchar_frame(
   "dadmom"  , "name", "inc" |
     "d"     , named , incd |
     "m"     , namem , incm )

## ------------------------------------------------------------------------
# put it all together into a layout
layout <- rowrecs_to_blocks_spec(
  outgoing_record,
  recordKeys = recordKeys)

# confirm we have the right layout
print(layout)


## ----eval=FALSE----------------------------------------------------------
#  # this is equivalent to the above call
#  rowrecs_to_blocks_spec(
#    outgoing_record,
#    recordKeys = recordKeys,
#    controlTableKeys = 'dadmom')

## ------------------------------------------------------------------------
# apply the layout
dadmomw %.>% 
  layout %.>%
  knitr::kable(.)

## ----eval=FALSE, include=FALSE-------------------------------------------
#  # how we got the below row. can't run yet since we haven't defined anything
#  grades %.>% blocks_to_rowrecs(., keyColumns= recordKeys, incoming_record)

## ------------------------------------------------------------------------
library("cdata")

# identify the record keys
recordKeys <- c("ID", "Year")

# specify the incoming record shape
incoming_record <- wrapr::qchar_frame(
  "Test"  , "Fall"   , "Spring"     , "Winter" |
    "1"   , Fall1    , Spring1      , Winter1  |
    "2"   , Fall2    , Spring2      , Winter2  )

# specify the outgoing record shape
outgoing_record <- wrapr::qchar_frame(
  "Time"     , "Test1" ,  "Test2"   |
    "Fall"   , Fall1   ,   Fall2    |
    "Spring" , Spring1 ,   Spring2  |
    "Winter" , Winter1 ,   Winter2  )

# put it all together into a layout
layout <- layout_specification(
  incoming_shape = incoming_record,
  outgoing_shape = outgoing_record,
  recordKeys = recordKeys)

# confirm we have the right layout
print(layout)

# example data
grades <- wrapr::build_frame(
   "ID"  , "Test", "Year", "Fall", "Spring", "Winter" |
     1   , 1     , 2008  , 15    , 16      , 19       |
     1   , 1     , 2009  , 12    , 13      , 27       |
     1   , 2     , 2008  , 22    , 22      , 24       |
     1   , 2     , 2009  , 10    , 14      , 20       |
     2   , 1     , 2008  , 12    , 13      , 25       |
     2   , 1     , 2009  , 16    , 14      , 21       |
     2   , 2     , 2008  , 13    , 11      , 29       |
     2   , 2     , 2009  , 23    , 20      , 26       |
     3   , 1     , 2008  , 11    , 12      , 22       |
     3   , 1     , 2009  , 13    , 11      , 27       |
     3   , 2     , 2008  , 17    , 12      , 23       |
     3   , 2     , 2009  , 14    ,  9      , 31       )

# apply the layout
grades %.>% 
  layout %.>%
  knitr::kable(.)

## ------------------------------------------------------------------------
a <- wrapr::build_frame(
   "Ind"   , "Treatment", "value" |
     "Ind1", "Treat"    , 1       |
     "Ind2", "Treat"    , 2       |
     "Ind1", "Cont"     , 3       |
     "Ind2", "Cont"     , 4       )

b <- wrapr::build_frame(
   "Ind"   , "Treat" , "Cont"|
     "Ind1", 1       , 3     |
     "Ind2", 2       , 4     )

## ----echo=FALSE----------------------------------------------------------
knitr::kable(b[1, , drop=FALSE])

## ------------------------------------------------------------------------
library("cdata")

# identify the record key
recordKeys <- "Ind"

# specify the incoming record shape
incoming_record <- wrapr::qchar_frame(
   "Treatment"  , "value" |
    "Treat"     , Treat   |
    "Cont"      , Cont    )


# put it all together into a layout
layout <- blocks_to_rowrecs_spec(
  incoming_record,
  recordKeys = recordKeys)

# confirm we have the right layout
print(layout)

# apply the layout
a %.>% 
  layout %.>%
  knitr::kable(.)

## ------------------------------------------------------------------------
a <- wrapr::build_frame(
   "Name"   , "50", "100", "150", "200", "250", "300", "350" |
     "Carla", 1.2 , 1.8  , 2.2  , 2.3  , 3    , 2.5  , 1.8   |
     "Mace" , 1.5 , 1.1  , 1.9  , 2    , 3.6  , 3    , 2.5   )

b <- wrapr::build_frame(
   "Name"   , "Time", "Score" |
     "Carla", 50    , 1.2     |
     "Carla", 100   , 1.8     |
     "Carla", 150   , 2.2     |
     "Carla", 200   , 2.3     |
     "Carla", 250   , 3       |
     "Carla", 300   , 2.5     |
     "Carla", 350   , 1.8     |
     "Mace" , 50    , 1.5     |
     "Mace" , 100   , 1.1     |
     "Mace" , 150   , 1.9     |
     "Mace" , 200   , 2       |
     "Mace" , 250   , 3.6     |
     "Mace" , 300   , 3       |
     "Mace" , 350   , 2.5     )

## ----echo=FALSE----------------------------------------------------------
knitr::kable(a[1, , drop=FALSE])

## ------------------------------------------------------------------------
library("cdata")

# how to find records
recordKeys <- "Name"

# specify the outgoing record shape, using a helper function
# (and print it --  notice that it's a data frame)
( outgoing_record <- build_unpivot_control(
  nameForNewKeyColumn = "Time",
  nameForNewValueColumn = "Score",
  columnsToTakeFrom = setdiff(colnames(a), recordKeys)) )

# put it all together into a layout
layout <- rowrecs_to_blocks_spec(
  outgoing_record,
  recordKeys = recordKeys)

# confirm we have the right layout
print(layout)

# apply the layout
a %.>% 
  layout %.>%
  transform(., Time = as.numeric(Time)) %.>%
  # sort the data frame by Name and then Time
  .[order(.$Name, .$Time), , drop = FALSE] %.>%
  knitr::kable(., row.names = FALSE)

## ------------------------------------------------------------------------
a <- wrapr::build_frame(
   "id"    , "trt", "work.T1", "play.T1", "talk.T1", "total.T1", "work.T2", "play.T2", "talk.T2", "total.T2" |
     "x1.1", "cnt", 0.3443   , 0.7842   , 0.1079   , 0.888     , 0.6484   , 0.8795   , 0.7234   , 0.5631     |
     "x1.2", "tr" , 0.06132  , 0.8427   , 0.3339   , 0.04686   , 0.2348   , 0.1971   , 0.5164   , 0.7618     )

b <- wrapr::build_frame(
   "id"    , "trt", "time", "work" , "play", "talk", "total" |
     "x1.1", "cnt", "T1"  , 0.3443 , 0.7842, 0.1079, 0.888   |
     "x1.1", "cnt", "T2"  , 0.6484 , 0.8795, 0.7234, 0.5631  |
     "x1.2", "tr" , "T1"  , 0.06132, 0.8427, 0.3339, 0.04686 |
     "x1.2", "tr" , "T2"  , 0.2348 , 0.1971, 0.5164, 0.7618  )

## ----echo=FALSE----------------------------------------------------------
knitr::kable(a[1, , drop=FALSE])

## ------------------------------------------------------------------------
library("cdata")

# identify the record keys
recordKeys <- c("id", "trt")

# specify the outgoing record shape
outgoing_record <- wrapr::qchar_frame(
    "time"  , "work" , "play" , "talk" , "total"  |
    "T1"    , work.T1, play.T1, talk.T1, total.T1 |
    "T2"    , work.T2, play.T2, talk.T2, total.T2 )

# put it all together into a layout
layout <- rowrecs_to_blocks_spec(
  outgoing_record,
  recordKeys = recordKeys)

# confirm we have the right layout
print(layout)

# apply the layout
a %.>% 
  layout %.>%
  # reorder the frame by the record keys plus time
  .[wrapr::orderv(.[ , c(recordKeys, "time"), drop = FALSE]), , drop = FALSE] %.>%
  knitr::kable(., row.names = FALSE)

## ------------------------------------------------------------------------
inv_layout <- t(layout)

print(inv_layout)

# apply the inverse layout
b %.>% 
  inv_layout %.>%
  knitr::kable(.)

