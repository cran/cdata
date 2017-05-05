## ----s1------------------------------------------------------------------
library("tibble")
d1 <- tribble(
  ~model, ~depth, ~testset, ~AUC, ~pR2,
  'a',    5,      'x',      0.4,  0.2,
  'a',    5,      'y',      0.6,  0.3,
  'b',    3,      'x',      0.5,  0.25,
  'b',    3,      'y',      0.5,  0.25
)
print(d1)

## ----s2------------------------------------------------------------------
models2 <- tribble(
  ~model, ~depth,
  'a',    5,
  'b',    3
)

d2 <- tribble(
  ~model, ~testset, ~AUC, ~pR2,
  'a',   'x',      0.4,  0.2,
  'a',   'y',      0.6,  0.3,
  'b',   'x',      0.5,  0.25,
  'b',   'y',      0.5,  0.25
)

print(models2)
print(d2)

## ----sc2to1--------------------------------------------------------------
library("dplyr", warn.conflicts= FALSE)

d1_2 <- left_join(d2, models2, by='model') %>%
  select(model, depth, testset, AUC, pR2) %>%
  arrange(model, testset)
print(d1_2)
all.equal(d1, d1_2)

## ----s3------------------------------------------------------------------
d3 <- tribble(
  ~model, ~depth, ~testset, ~measurement, ~value,
  'a',    5,      'x',      'AUC',        0.4,
  'a',    5,      'x',      'pR2',        0.2,
  'a',    5,      'y',      'AUC',        0.6,
  'a',    5,      'y',      'pR2',        0.3,
  'b',    3,      'x',      'AUC',        0.5,
  'b',    3,      'x',      'pR2',        0.25,
  'b',    3,      'y',      'AUC',        0.5,
  'b',    3,      'y',      'pR2',        0.25
)
print(d3)

## ----sc3to1--------------------------------------------------------------
library("tidyr")

d1_3 <- d3 %>%
  spread('measurement', 'value') %>%
  select(model, depth, testset, AUC, pR2) %>%  # to guarantee column order
  arrange(model, testset)  # to guarantee row order
print(d1_3)
all.equal(d1, d1_3)

## ----eval=FALSE----------------------------------------------------------
#    moveValuesToColumns(data = d3,
#                        columnToTakeKeysFrom = 'measurement',
#                        columnToTakeValuesFrom = 'value',
#                        rowKeyColumns = c('model', 'testset'))

## ----s4------------------------------------------------------------------
d4 <- tribble(
  ~model, ~depth, ~x_AUC, ~x_pR2, ~y_AUC, ~y_pR2,
  'a',    5,      0.4,    0.2,   0.6,    0.3,
  'b',    3,      0.5,    0.25,  0.5,    0.25
)

print(d4)

## ----s4t1----------------------------------------------------------------
d3_4 <- d4 %>%
  gather('meas', 'value', x_AUC, y_AUC, x_pR2, y_pR2) %>%
  separate(meas, c('testset', 'measurement')) %>%
  select(model, depth, testset, measurement, value) %>%
  arrange(model, testset, measurement)
print(d3_4)
all.equal(d3, d3_4)

## ----eval=FALSE----------------------------------------------------------
#   moveValuesToRows(data = d4,
#                    nameForNewKeyColumn = 'meas',
#                    nameForNewValueColumn = 'value',
#                    columnsToTakeFrom = c('x_AUC', 'y_AUC', 'x_pR2', 'y_pR2'))

## ----lookup--------------------------------------------------------------
# take a map from names to scalar conditions and return a value.
# inefficient method; notional only
lookup <- function(key) {
  table <- get(key[['Table']])
  col <- key[['ValueColumn']]
  conditions <- setdiff(names(key), 
                        c('Table', 'ValueColumn'))
  for(ci in conditions) {
    table <- table[table[[ci]]==key[[ci]], ,
                   drop= FALSE]
  }
  table[[col]][[1]]
}

k1 <- c(Table='d1', model='a', testset='y', 
        ValueColumn='AUC')
k2 <- c(Table='d2', model='a', testset='y', 
        ValueColumn='AUC')
k3 <- c(Table='d3', model='a', testset='y', 
        measurement='AUC', ValueColumn='value')
k4 = c(Table='d4', model='a', 
       ValueColumn= paste('y', 'AUC', sep= '_'))

print(lookup(k1))
print(lookup(k2))
print(lookup(k3))
print(lookup(k4))

## ----moveValuesToRows----------------------------------------------------
library("cdata")

## ----sc1to3--------------------------------------------------------------
d3from1 <- moveValuesToRows(data=d1,
                            nameForNewKeyColumn= 'measurement',
                            nameForNewValueColumn= 'value',
                            columnsToTakeFrom = c('AUC', 'pR2')) %>%
  select(model, depth, testset, measurement, value) %>%
  arrange(model, testset, measurement)
print(d3from1)
all.equal(d3, d3from1)

## ----sc1to3_1row---------------------------------------------------------
row <- d1[3,]
print(row)

moveValuesToRows(data=row,
                 nameForNewKeyColumn= 'measurement',
                 nameForNewValueColumn= 'value',
                 columnsToTakeFrom = c('AUC', 'pR2')) %>%
  select(model, depth, testset, measurement, value) %>%
  arrange(model, testset, measurement)

## ----mvtce---------------------------------------------------------------
d1from3 <- moveValuesToColumns(data= d3,
                    columnToTakeKeysFrom= 'measurement',
                    columnToTakeValuesFrom= 'value',
                    rowKeyColumns= c('model', 'testset')) %>%
  select(model, depth, testset, AUC, pR2) %>%
  arrange(model, testset)
print(d1from3)
all.equal(d1, d1from3)

## ----spreaddam1, error=TRUE----------------------------------------------
d3damaged <- d3
d3damaged$testset <- 'z'
print(d3damaged)
spread(d3damaged, 'measurement', 'value')

## ----spreaddam2, error=TRUE----------------------------------------------
moveValuesToColumns(data= d3damaged,
                    columnToTakeKeysFrom= 'measurement',
                    columnToTakeValuesFrom= 'value',
                    rowKeyColumns= c('model', 'testset'))

## ----depthprob-----------------------------------------------------------
d3damaged <- d3
d3damaged$depth <- seq_len(nrow(d3damaged))
print(d3damaged)
spread(d3damaged, 'measurement', 'value') 

## ----depthprob2, error=TRUE----------------------------------------------
moveValuesToColumns(data= d3damaged,
                    columnToTakeKeysFrom= 'measurement',
                    columnToTakeValuesFrom= 'value',
                    rowKeyColumns= c('model', 'testset'))

