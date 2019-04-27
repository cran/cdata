## ----setup, include = FALSE----------------------------------------------
knitr::opts_chunk$set(
  collapse = TRUE,
  comment = "#>"
)

## ------------------------------------------------------------------------
library(cdata)

iris <- data.frame(iris)
iris$iris_id <- seq_len(nrow(iris))

head(iris, n=1)

## ------------------------------------------------------------------------
controlTable <- wrapr::qchar_frame(
  "flower_part", "Length"      , "Width"     |
  "Petal"      , Petal.Length  , Petal.Width |
  "Sepal"      , Sepal.Length  , Sepal.Width )

layout <- rowrecs_to_blocks_spec(
  controlTable,
  recordKeys = c("iris_id", "Species"))

print(layout)

## ------------------------------------------------------------------------
iris %.>%
  head(., n = 1) %.>%
  knitr::kable(.)

iris_aug <- iris %.>%
  head(., n = 1) %.>%
  layout

iris_aug %.>%
  knitr::kable(.)

## ------------------------------------------------------------------------
# re-do the forward transform, this time
# with more records so we can see more
iris_aug <- iris %.>%
  head(., n = 3) %.>%
  layout

knitr::kable(iris_aug)

inv_layout <- t(layout)

print(inv_layout)

# demonstrate the reverse transform
iris_back <- iris_aug %.>%
  inv_layout

knitr::kable(iris_back)

