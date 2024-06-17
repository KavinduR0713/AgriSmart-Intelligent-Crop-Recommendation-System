#TASK 01
# Maximize agricultural yield by recommending appropriate crops using classification algorithm and R.

# step 01 
library(readr)
crop_rec <- read_csv("Crop_recommendation (1).csv")

install.packages('caTools') #for train and test data split
install.packages('dplyr') #for Data Manipulation
install.packages('ggplot2') #for Data Visualization
install.packages('class') #KNN
install.packages('caret') #Confusion Matrix
install.packages('corrplot') #Correlation Plot
library(caTools)
library(dplyr)
library(ggplot2)
library(caret)
library(class)
library(corrplot)

#step 2
names(crop_rec)

#step 3
summary(crop_rec)

#step 4
head(crop_rec)
tail(crop_rec)

#step5
str(crop_rec)

#step 6
standard.features <- scale(crop_rec[,1:7])
#Join the standardized data with the target column
data <- cbind(standard.features,crop_rec[8])
head(data)

#step 7
anyNA(data)

#step 8
dim(crop_rec)

#step 9
corrplot(cor(data[,-8]))

#step 10
set.seed(101)
# sample.split() function is used to divide the data into two sets, train set and test set
sample <- sample.split(data$label,SplitRatio = 0.70)
train <- subset(data,sample==TRUE)
dim(train)
test <- subset(data,sample==FALSE)
dim(test)

#step 11
predicted.type <- knn(train[1:7], test[1:7], train$label,k=1)
#Error in prediction
error <- mean(predicted.type!=test$label)
#Confusion Matrix
confusionMatrix(predicted.type,as.factor(test$label))

#step 12
predicted.type <- NULL
error.rate <- NULL
for (i in 1:7) {
  predicted.type <- knn(train[1:7],test[1:7],train$label,k=i)
  error.rate[i] <- mean(predicted.type!=test$label)
}
knn.error <- as.data.frame(cbind(k=1:10,error.type =error.rate))
knn.error

#step 13
ggplot(knn.error,aes(k,error.type))+ 
  geom_point()+ 
  geom_line() + 
  scale_x_continuous(breaks=1:10)+ 
  theme_bw() +
  xlab("Value of K") +
  ylab('Error')

#step 14
predicted.type <- knn(train[1:7],test[1:7],train$label,k=3)
#Error in prediction
error <- mean(predicted.type!=test$label)
error
#Confusion Matrix
confusionMatrix(predicted.type,as.factor(test$label))

