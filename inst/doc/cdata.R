## ------------------------------------------------------------------------
library("cdata")

# first few rows of the iris data as an example
d <- wrapr::build_frame(
   "Sepal.Length"  , "Sepal.Width", "Petal.Length", "Petal.Width", "Species" |
     5.1           , 3.5          , 1.4           , 0.2          , "setosa"  |
     4.9           , 3            , 1.4           , 0.2          , "setosa"  |
     4.7           , 3.2          , 1.3           , 0.2          , "setosa"  |
     4.6           , 3.1          , 1.5           , 0.2          , "setosa"  |
     5             , 3.6          , 1.4           , 0.2          , "setosa"  |
     5.4           , 3.9          , 1.7           , 0.4          , "setosa"  )
d$iris_id <- seq_len(nrow(d))

knitr::kable(d)

## ------------------------------------------------------------------------
record_example <- wrapr::qchar_frame(
   "plant_part"  , "measurement", "value"      |
     "sepal"     , "width"      , Sepal.Width  |
     "sepal"     , "length"     , Sepal.Length |
     "petal"     , "width"      , Petal.Width  |
     "petal"     , "length"     , Petal.Length )

knitr::kable(record_example)

## ------------------------------------------------------------------------
layout <- rowrecs_to_blocks_spec(
  record_example,
  controlTableKeys = c("plant_part", "measurement"),
  recordKeys = c("iris_id", "Species"))

print(layout)

## ------------------------------------------------------------------------
d_transformed <- d %.>% 
  layout

knitr::kable(d_transformed)

## ------------------------------------------------------------------------
inv_layout <- t(layout)

print(inv_layout)

d_transformed %.>%
  inv_layout %.>%
  knitr::kable(.)

## ------------------------------------------------------------------------
unclass(layout)

