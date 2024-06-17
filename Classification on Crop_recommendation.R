library(caTools)
library(dplyr)
library(ggplot2)
library(caret)
library(class)
library(corrplot)

Crop_recommendation <- read.csv("Crop_recommendation.csv")



names(Crop_recommendation) 
head(Crop_recommendation) 
tail(Crop_recommendation) 
summary(Crop_recommendation) 
str(Crop_recommendation)
dim(Crop_recommendation)

standard.features <- scale(Crop_recommendation[,1:7])
#Join the standardized data with the target column 
data <- cbind(standard.features,Crop_recommendation[8]) 
head(data)

anyNA(data)

corrplot(cor(data[,-8]))

set.seed(101)

sample <- sample.split(data$label,SplitRatio = 0.70)
train <- subset(data,sample==TRUE)
dim(train)
test <- subset(data,sample==FALSE)
dim(test)

predicted.type <- knn(train[1:7], test[1:7], train$label,k=1)
#Error in prediction
error <- mean(predicted.type!=test$label)
#Confusion Matrix
confusionMatrix(predicted.type,as.factor(test$label))

predicted.type <- NULL
error.rate <- NULL
for (i in 1:7) {
  predicted.type <- knn(train[1:7],test[1:7],train$label,k=i)
  error.rate[i] <- mean(predicted.type!=test$label)
}
knn.error <- as.data.frame(cbind(k=1:10,error.type =error.rate))
knn.error

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