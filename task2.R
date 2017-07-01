
#this is done to set the working directory
#first the directory is saved in projectWD object
projectWD = "D:/DocumentsUTU/DataAnalysisAndKnowledgeDiscovery/exercise1"

#Then set the WD using this object
setwd(projectWD)

# #to set the working directory of the project
# setwd("D:/DocumentsUTU/DataAnalysisAndKnowledgeDiscovery/exercise1")

#to get the workind directory (WD)
getwd()

#to import the data into R with header and seprator by choosing the file
data = read.csv(file.choose(), header=T, sep = ";")

#load the libraries
#install.packages("ISLR")
library(ISLR)
library(caret)
library(FNN)

#to store the variables in R's memory
attach(data)

#data = WineQualityWhite

#We use this command to see whether the data is structured or not.
str(data)

# it helps us to get the numbers of of rows with different quality
table(quality)


#head(normalizedData)

# check if fixed acidity is normalized or not
summary(fixed.acidity)

#splitting data randomly into 80% and 20% half
set.seed(300)
trainIndex = createDataPartition(quality, p = .8, 
                                  list = FALSE, 
                                  times = 1)
head(trainIndex)
str(trainIndex)

#dividing data into test and train data
dataTrainX = data [trainIndex,]
dataTrainY = data[trainIndex, "quality"]

dataTestX = data [-trainIndex,]
dataTestY = data[-trainIndex, "quality"]

#Checking distibution in origanl data and partitioned data
prop.table(table(dataTrainY)) * 100
prop.table(table(dataTestY)) * 100
prop.table(table(data$quality)) * 100

#Pre-Processing of the train dataset
trainX = dataTrainX[, names(dataTrainX) != "quality"]
preProcValues = preProcess(x=trainX, method = c("center", "scale"))
preProcTrain = cbind(trainX, dataTrainY)
colnames(preProcTrain)[12] = "quality"

testX = dataTestX[, names(dataTestX) != "quality"]
preProcValues = preProcess(x=testX, method = c("center", "scale"))
preProcTest = cbind(testX, dataTestY)
colnames(preProcTest)[12] = "quality"

#Creating a model
Fit = knnreg(preProcTrain, test = NULL, dataTrainY, k = 11, use.all = TRUE)
#Fit = knn.reg(preProcTrain, test = NULL, dataTrainY, k = 11, algorithm="kd_tree")
summary(Fit)
Fit


#Trainning and train control with 10 repetation
set.seed(500)
ctrl <- trainControl(method="repeatedcv", number = 10, repeats = 10) 
knnFit <- train(quality ~ ., data = data, method = "knn", trControl = ctrl, 
                preProcess = c("center","scale"), tuneLength = 20)

#Output of kNN fit
knnFit

#?predict
#knnPredict = predict(knnFit,newdata = dataTestX)
#knnPredict
mean(knnPredict - dataTestY)

#Plotting yields Number of Neighbours Vs accuracy (based on repeated cross validation)
plot(knnFit)

#Model Diagnostics and Scoring
residuals = resid(knnFit)
predictedValues = predict(knnFit)

#Scatter plot of residuals Versus predictor
plot(predictedValues,residuals, main = "Trainning Predicted Values Vs Residuals", xlab = "Trainning Predicted Values",
     ylab = "Residuals",col=c("Red","Green"), las=1)
abline(0,0)
legend("bottomright",legend=c('Trainning Predicted Values','Residuals'),text.col=c("Red","Green") , lty=1 ,col= c("Red","Green"))

#plot(dataTrainY,residuals, main = "Trainning Actual Values Vs Residuals", xlab = "Actual Values",
#     ylab = "Residuals",col=c("Green","Red"), las=1)
#abline(0,0)
#legend("bottomright",legend=c('Actual Training Values','Residuals'),text.col=c("Green","Red") , lty=1 ,col= c("Green","Red"))

#plot of tranning Actual values vc predicted values
plot(dataTrainY, type = "l", main = "Tranning Actual values vc Predicted values", 
    xlab = "Number of Samples", ylab = "Quality", col="Green")
lines(predictedValues, col = "Red")
legend("bottomright",legend=c('Actual','Predicted'),text.col=c("Green","Red") , lty=1 ,col= c("Green","Red"))

#Scatter plot of actual test values and prediction value
plot(data[,"quality"],predictedValues, main = "Actual Vs Predicted Quality", col =c("Green","Red"),xlab='Actual Quality' , ylab='Predicted Quality')
#lines(testFit, type = "l", col="Red")
legend("bottomright",legend=c('Actual','Predicted'),text.col=c("Green","Red") , lty=1 ,col= c("Green","Red"))


#traning data set
#ctrlTrain <- trainControl(method="repeatedcv", number = 2, repeats = 1)
#FitTrain = train(quality~., data = dataTrainX, method="knn", trControl = ctrlTrain, preProcess = c("center","scale"), tuneLength = 20)
#FitTrain

#plot training reasult
#plot(FitTrain)

#ctrlTest <- trainControl(method="repeatedcv", number = 2, repeats = 1)
#FitTest = train(quality~., data = dataTestX, method="knn", trControl = ctrlTest, preProcess = c("center","scale"), tuneLength = 20)
#FitTest
#plot(FitTest)
#lines(FitTrain)

#Testing the model with test dataset
testFit = predict(Fit, preProcTest)
summary(testFit)

#modle performance
modelValues = data.frame(obs=dataTestY, pred=testFit)
defaultSummary(modelValues)

#Plot of actual vs prediction
plot(dataTestY, type = "l", main = "Actual Vs Predicted Quality", col = "Green",xlab='Number of Test Samples' , ylab='Quality')
lines(testFit, type = "l", col="Red")
legend("bottomright",legend=c('Actual','Predicted'),text.col=c("Green","Red") , lty=1 ,col= c("Green","Red"))

#Scatter plot of actual test values and prediction value
plot(dataTestY,testFit, main = "Actual Vs Predicted Quality", col =c("Green","Red"),xlab='Actual Quality' , ylab='Predicted Quality')
#lines(testFit, type = "l", col="Red")
legend("bottomright",legend=c('Actual','Predicted'),text.col=c("Green","Red") , lty=1 ,col= c("Green","Red"))

