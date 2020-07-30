# ready
rm(list=ls())
setwd('C://Users//User//Desktop//Dev//2020_Summer_Study//RUS')

# library
library(spatstat); library(ROSE); library(glmnet); library(ncpen)
library(ggplot2); library(corrplot); library(lars)
library(glmnet);library(ncvreg); library(genlasso)
library(FGSG); library(grplasso)
library(xgboost); library(Matrix); 
library(dplyr); library(e1071); library(caret); library(randomForest)

# 1. Data load : reduced_train_0730, reduced_test_0730
train = read.csv(file='reduced_train_0730.csv')
test = read.csv(file='reduced_test_0730.csv')

# 2. Data Frame ¸¸µé±â : layer1~4 = y1~4

## y1 dataframe
df1 = train['layer_1']
df1 = cbind(df1,train[,-c(1:4)])
## y2 dataframe
df2 = train['layer_2']
df2 = cbind(df2,train[,-c(1:4)])
## y3 dataframe
df3 = train['layer_3']
df3 = cbind(df3,train[,-c(1:4)])
## y4 dataframe
df4 = train['layer_4']
df4 = cbind(df4,train[,-c(1:4)])

dim(train);dim(test)
summary(train);summary(test)
str(train);str(test)

# check na skip




