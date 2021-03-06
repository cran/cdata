

#' Build a blocks_to_rowrecs()/rowrecs_to_blocks() control table that specifies a pivot from a \code{data.frame}.
#'
#' Some discussion and examples can be found here: \url{https://winvector.github.io/FluidData/FluidData.html}.
#'
#' @param table data.frame to scan for new column names (in-memory data.frame).
#' @param columnToTakeKeysFrom character name of column build new column names from.
#' @param columnToTakeValuesFrom character name of column to get values from.
#' @param ... not used, force later args to be by name
#' @param prefix column name prefix (only used when sep is not NULL)
#' @param sep separator to build complex column names.
#' @param tmp_name_source a tempNameGenerator from cdata::mk_tmp_name_source()
#' @param temporary logical, if TRUE use temporary tables
#' @return control table
#'
#' @seealso \code{\link{blocks_to_rowrecs}}
#'
#' @examples
#'
#'   d <- data.frame(measType = c("wt", "ht"),
#'                   measValue = c(150, 6),
#'                   stringsAsFactors = FALSE)
#'   build_pivot_control(d,
#'                       'measType', 'measValue',
#'                       sep = '_')
#'
#' @export
build_pivot_control <- function(table,
                                columnToTakeKeysFrom,
                                columnToTakeValuesFrom,
                                ...,
                                prefix = columnToTakeKeysFrom,
                                sep = NULL,
                                tmp_name_source = wrapr::mk_tmp_name_source("bpc"),
                                temporary = FALSE) {
  UseMethod("build_pivot_control")
}




#' Map a data records from row records to block records.
#'
#' Map a data records from row records (records that are exactly single rows) to block records
#' (records that may be more than one row).
#'
#' The controlTable defines the names of each data element in the two notations:
#' the notation of the tall table (which is row oriented)
#' and the notation of the wide table (which is column oriented).
#' controlTable[ , 1] (the group label) cross colnames(controlTable)
#' (the column labels) are names of data cells in the long form.
#' controlTable[ , 2:ncol(controlTable)] (column labels)
#' are names of data cells in the wide form.
#' To get behavior similar to tidyr::gather/spread one builds the control table
#' by running an appropriate query over the data.
#'
#' Some discussion and examples can be found here:
#' \url{https://winvector.github.io/FluidData/FluidData.html} and
#' here \url{https://github.com/WinVector/cdata}.
#'
#' \code{rowrecs_to_blocks.default} will change some factor columns to character, and there
#' are issues with time columns with different time zones.
#'
#' @param wideTable data.frame containing data to be mapped (in-memory data.frame).
#' @param controlTable table specifying mapping (local data frame).
#' @param ... force later arguments to be by name.
#' @param columnsToCopy character array of column names to copy.
#' @param checkNames logical, if TRUE check names.
#' @param checkKeys logical, if TRUE check columnsToCopy form row keys (not a requirement, unless you want to be able to invert the operation).
#' @param strict logical, if TRUE check control table name forms.
#' @param controlTableKeys character, which column names of the control table are considered to be keys.
#' @param tmp_name_source a tempNameGenerator from cdata::mk_tmp_name_source()
#' @param temporary logical, if TRUE use temporary tables
#' @param allow_rqdatatable logical, if TRUE allow rqdatatable shortcutting on simple conversions.
#' @return long table built by mapping wideTable to one row per group
#'
#' @seealso \code{\link{build_unpivot_control}}, \code{\link{blocks_to_rowrecs}}
#'
#' @examples
#'
#'   # un-pivot example
#'   d <- data.frame(AUC = 0.6, R2 = 0.2)
#'   cT <- build_unpivot_control(nameForNewKeyColumn= 'meas',
#'                               nameForNewValueColumn= 'val',
#'                               columnsToTakeFrom= c('AUC', 'R2'))
#'   rowrecs_to_blocks(d, cT)
#'
#'
#' @export
#'
rowrecs_to_blocks <- function(wideTable,
                              controlTable,
                              ...,
                              checkNames = TRUE,
                              checkKeys = FALSE,
                              strict = FALSE,
                              controlTableKeys = colnames(controlTable)[[1]],
                              columnsToCopy = NULL,
                              tmp_name_source = wrapr::mk_tmp_name_source("rrtbl"),
                              temporary = TRUE,
                              allow_rqdatatable = FALSE) {
  UseMethod("rowrecs_to_blocks")
}




#' Map data records from block records to row records.
#'
#' Map data records from block records (which each record may be more than one row) to
#' row records (where each record is a single row).
#'
#' The controlTable defines the names of each data element in the two notations:
#' the notation of the tall table (which is row oriented)
#' and the notation of the wide table (which is column oriented).
#' controlTable[ , 1] (the group label) cross colnames(controlTable)
#' (the column labels) are names of data cells in the long form.
#' controlTable[ , 2:ncol(controlTable)] (column labels)
#' are names of data cells in the wide form.
#' To get behavior similar to tidyr::gather/spread one builds the control table
#' by running an appropriate query over the data.
#'
#' Some discussion and examples can be found here:
#' \url{https://winvector.github.io/FluidData/FluidData.html} and
#' here \url{https://github.com/WinVector/cdata}.
#'
#' @param tallTable data.frame containing data to be mapped (in-memory data.frame).
#' @param keyColumns character vector of column defining row groups
#' @param controlTable table specifying mapping (local data frame)
#' @param ... force later arguments to be by name.
#' @param columnsToCopy character, extra columns to copy.
#' @param checkNames logical, if TRUE check names.
#' @param checkKeys logical, if TRUE check keyColumns uniquely identify blocks (required).
#' @param strict logical, if TRUE check control table name forms
#' @param controlTableKeys character, which column names of the control table are considered to be keys.
#' @param tmp_name_source a tempNameGenerator from cdata::mk_tmp_name_source()
#' @param temporary logical, if TRUE use temporary tables
#' @param allow_rqdatatable logical, if TRUE allow rqdatatable shortcutting on simple conversions.
#' @return wide table built by mapping key-grouped tallTable rows to one row per group
#'
#' @seealso \code{\link{build_pivot_control}}, \code{\link{rowrecs_to_blocks}}
#'
#' @examples
#'
#'   # pivot example
#'   d <- data.frame(meas = c('AUC', 'R2'),
#'                   val = c(0.6, 0.2))
#'
#'   cT <- build_pivot_control(d,
#'                             columnToTakeKeysFrom= 'meas',
#'                             columnToTakeValuesFrom= 'val')
#'   blocks_to_rowrecs(d,
#'                     keyColumns = NULL,
#'                     controlTable = cT)
#'
#' @export
#'
blocks_to_rowrecs <- function(tallTable,
                              keyColumns,
                              controlTable,
                              ...,
                              columnsToCopy = NULL,
                              checkNames = TRUE,
                              checkKeys = TRUE,
                              strict = FALSE,
                              controlTableKeys = colnames(controlTable)[[1]],
                              tmp_name_source = wrapr::mk_tmp_name_source("bltrr"),
                              temporary = TRUE,
                              allow_rqdatatable = FALSE) {
  UseMethod("blocks_to_rowrecs")
}




#' Map a data records from row records to block records with one record row per columnsToTakeFrom value.
#'
#' Map a data records from row records (records that are exactly single rows) to block records
#' (records that may be more than one row).  All columns not named in columnsToTakeFrom are copied to each
#' record row in the result.
#'
#'
#' @param data data.frame to work with.
#' @param nameForNewKeyColumn character name of column to write new keys in.
#' @param nameForNewValueColumn character name of column to write new values in.
#' @param columnsToTakeFrom character array names of columns to take values from.
#' @param ... force later arguments to bind by name.
#' @param nameForNewClassColumn optional name to land original cell classes to.
#' @param checkNames logical, if TRUE check names.
#' @param checkKeys logical, if TRUE check columnsToCopy form row keys (not a requirement, unless you want to be able to invert the operation).
#' @param strict logical, if TRUE check control table name forms.
#' @param tmp_name_source a tempNameGenerator from cdata::mk_tmp_name_source()
#' @param temporary logical, if TRUE make result temporary.
#' @param allow_rqdatatable logical, if TRUE allow rqdatatable shortcutting on simple conversions.
#' @return new data.frame with values moved to rows.
#'
#' @seealso \code{\link{pivot_to_rowrecs}}, \code{\link{rowrecs_to_blocks}}
#'
#' @examples
#'
#'   d <- data.frame(model_name = "m1", AUC = 0.6, R2 = 0.2)
#'   unpivot_to_blocks(d,
#'                     nameForNewKeyColumn= 'meas',
#'                     nameForNewValueColumn= 'val',
#'                     columnsToTakeFrom= c('AUC', 'R2')) %.>%
#'      print(.)
#'
#' @export
#'
#'
unpivot_to_blocks <- function(data,
                              nameForNewKeyColumn,
                              nameForNewValueColumn,
                              columnsToTakeFrom,
                              ...,
                              nameForNewClassColumn = NULL,
                              checkNames = TRUE,
                              checkKeys = FALSE,
                              strict = FALSE,
                              tmp_name_source = wrapr::mk_tmp_name_source("upb"),
                              temporary = TRUE,
                              allow_rqdatatable = FALSE) {
  UseMethod("unpivot_to_blocks")
}

#' @rdname unpivot_to_blocks
#' @export
layout_to_blocks <- unpivot_to_blocks

#' @rdname unpivot_to_blocks
#' @export
pivot_to_blocks <- unpivot_to_blocks
