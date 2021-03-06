## ----setup, include = FALSE---------------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## -----------------------------------------------------------------------------
library("cdata")

data <- wrapr::build_frame(
   "record_id"  , "row" , "col1", "col2", "col3" |
     1          , "row1", 1     , 2     , 3      |
     1          , "row2", 4     , 5     , 6      |
     1          , "row3", 7     , 8     , 9      |
     2          , "row1", 11    , 12    , 13     |
     2          , "row2", 14    , 15    , 16     |
     2          , "row3", 17    , 18    , 19     )

knitr::kable(data)

## -----------------------------------------------------------------------------
recordKeys = 'record_id'

incoming_shape <- wrapr::qchar_frame(
   "row"   , "col1", "col2", "col3" |
     "row1", v11   , v12   , v13    |
     "row2", v21   , v22   , v23    |
     "row3", v31   , v32   , v33    )

## -----------------------------------------------------------------------------
outgoing_shape <- wrapr::qchar_frame(
   "column_label"  , "c_row1", "c_row2", "c_row3" |
     "rec_col1"    , v11     , v21     , v31      |
     "rec_col2"    , v12     , v22     , v32      |
     "rec_col3"    , v13     , v23     , v33      )

## -----------------------------------------------------------------------------
layout <- layout_specification(
  incoming_shape = incoming_shape,
  outgoing_shape = outgoing_shape,
  recordKeys = recordKeys)

print(layout)

## -----------------------------------------------------------------------------
data %.>%
  layout %.>%
  knitr::kable(.)

## -----------------------------------------------------------------------------
lr <- layout_by(layout, data)
knitr::kable(lr)

cr <- convert_records(
  data,
  keyColumns = recordKeys,
  incoming_shape = incoming_shape,
  outgoing_shape = outgoing_shape)

knitr::kable(cr)

## -----------------------------------------------------------------------------
inv_layout <- t(layout)

print(inv_layout)

data %.>%
  layout %.>%
  inv_layout %.>%
  knitr::kable(.)

## -----------------------------------------------------------------------------
table_desciption <- rquery::local_td(data)
ops <- table_desciption %.>%
  layout

cat(format(ops))

rquery::column_names(ops) 

if(requireNamespace("DBI", quietly = TRUE) &&
   requireNamespace("RSQLite", quietly = TRUE)) {
  raw_connection <- DBI::dbConnect(RSQLite::SQLite(), 
                                   ":memory:")
  RSQLite::initExtension(raw_connection)
  db <- rquery::rquery_db_info(
    connection = raw_connection,
    is_dbi = TRUE,
    connection_options = rquery::rq_connection_tests(raw_connection))
  
  db_td <- rquery::rq_copy_to(db, "data", data)
  
  ops %.>% 
    db %.>% 
    knitr::kable(.) %.>%
    print(.)
  
  DBI::dbDisconnect(raw_connection)
}

