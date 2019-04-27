## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
# get a small sample of irises
iris <- head(iris, n = 3)
# add a record id to iris
iris$iris_id <- seq_len(nrow(iris))

knitr::kable(iris)

## ------------------------------------------------------------------------
library("cdata")

controlTable <- wrapr::qchar_frame(
  "flower_part", "Length"    , "Width"     |
  "Petal"      , Petal.Length, Petal.Width |
  "Sepal"      , Sepal.Length, Sepal.Width )

layout <- rowrecs_to_blocks_spec(
  controlTable,
  recordKeys = c("iris_id", "Species"))

print(layout)

## ------------------------------------------------------------------------
iris %.>%
  knitr::kable(.)
  
iris_aug <- iris %.>% 
  layout

iris_aug %.>%
  knitr::kable(.)

## ------------------------------------------------------------------------
inv_layout <- t(layout)

print(inv_layout)

iris_aug %.>%
  inv_layout %.>%
  knitr::kable(.)

