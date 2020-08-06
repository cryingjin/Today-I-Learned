# ready
rm(list=ls())
setwd('C://Users//jinji//Desktop//RUS')

# library
library(spatstat); library(ROSE); library(glmnet); library(ncpen)
library(ggplot2); library(corrplot); library(lars)
library(glmnet);library(ncvreg); library(genlasso)
library(FGSG); library(grplasso)
library(xgboost); library(Matrix); 
library(dplyr); library(e1071); library(caret); library(randomForest)
#install.packages('tidyverse')
library(tidyverse)
##########################################################################
# 1. Data load : reduced_train_0730, reduced_test_0730
##########################################################################
train = read.csv(file='reduced_train_0806.csv')
test = read.csv(file='reduced_test_0806.csv')

dim(train);dim(test)     # 81000   230
summary(train);summary(test)      # 한눈에 안들어옴, 모두 numeric
str(train);str(test)

# summary 결과를 Transpose 시킴
head(do.call(rbind, unclass(sapply(train, summary))))
head(do.call(rbind, unclass(sapply(test, summary))))

##########################################################################
# 2. Data Frame : layer1~4 = y1~4
##########################################################################
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

##########################################################################
# 3. EDA & Data Handling : layer1~4 = y1~4
# ref https://velog.io/@suzin/R-%EC%8B%9C%EA%B0%81%ED%99%94-ggplot2%EB%A1%9C-%EA%B7%B8%EB%A6%B0-boxplot%EC%83%81%EC%9E%90%EA%B7%B8%EB%A6%BC
# https://choonghyunryu.github.io/blog/2018-05/dlookr-%EB%8D%B0%EC%9D%B4%ED%84%B0%EC%A7%84%EB%8B%A8-eda-%EB%8D%B0%EC%9D%B4%ED%84%B0%EB%B3%80%ED%99%98%EC%9D%84-%EC%9C%84%ED%95%9C-%ED%8C%A8%ED%82%A4%EC%A7%80/
##########################################################################
# check na - total data
sum(is.na(train))
sum(is.na(test))    # 0

# df1
# 컬럼별 분포
par(mfrow=c(1,1))
par(mfrow=c(2,2))
boxplot(df1['X123'])
boxplot(df2['layer_2'])
boxplot(df3['layer_3'])
boxplot(df4['layer_4'])

str(df1[1])

for (i in 1:dim(df1)[2]){
  bp = boxplot(df1[i]) + geom_boxplot() + theme(axis.text = element_text(size=10))
  ggsave(bp, file=paste('C://Users//jinji//Desktop//RUS/',names(df1)[i], ".png", sep=''), scale=2)
  }     # X225 만 저장되네욥


for(i in range(df1)){
  plot.num=ggplot(data=df1, aes(x=layer_1,y=df1[,i],color=layer_1)) + geom_boxplot() +
    theme(axis.text = element_text(size=10))
  ggsave(plot.num, file=paste('C://Users//jinji//Desktop//RUS/',names(df1)[i], ".png", sep=''), scale=2)
}      #  `device` must be NULL, a string or a function.

ggplot2::ggplot(mapping = aes(y = df1[1])) + # Y를 price 변수로 지정
ggplot2::geom_boxplot() # price 변수를 기준으로 boxplot 생성

# 이상치
library(dlookr)
summary(diagnose_outlier(df1))
diagnose_outlier(df1)      # IQR 밖의 d이상치 진단

df1 %>%
  plot_outlier(diagnose_outlier(df1) %>% 
                 filter(outliers_ratio >= 0.5) %>% 
                 select(variables) %>% 
                 unlist())
# dplyr 패키지의 함수를 사용하여 이상치의 비율이 0.5% 이상인 
# 모든 수치형 변수의 이상치를 시각화 한다. -> 219 ~ 225

plot(df1$X225,df1$layer_1)
length(df1$X225); length(df1$layer_1)
