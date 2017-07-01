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
#library(ISLR)
library(caret)

#to store the variables in R's memory
attach(data)

#data = WineQualityWhite

#We use this command to see whether the data is structured or not.
str(data)

# it helps us to get the numbers of of rows with different quality
table(quality)

#generate z-scores for variable A using the scale() function
# w exclude integer attribute quality because it is the prediction value 
#normalizedData = scale(data[1:12], center = TRUE, scale = TRUE)

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

#set.seed(500)
#cv_splits = createFolds(data[,"quality"], k = 10, returnTrain = TRUE)
#str(cv_splits)

#Pre-Processing of the train dataset
#trainX = dataTrainX[, names(dataTrainX) != "quality"]
#preProcValues = preProcess(x=trainX, method = c("center", "scale"))
#preProcValues

#Model Building
lmFit = train(quality~., data = dataTrainX, preProcess=c("center","scale"), 
              method = "lm")
summary(lmFit)

#train control function to conduct cross validation
set.seed(600)
ctrl = trainControl(method = "repeatedcv", number = 10, repeats = 10)
lmFitCV = train(quality~., data = data, method ="lm",preProcess = c("center","scale"),
                trControl = ctrl, metric = "Rsquared")
summary(lmFitCV)
lmFitCV
#Model Diagnostics and Scoring
residuals = resid(lmFit)
predictedValues = predict(lmFit)

#Scatter plot of residuals Versus predictor
plot(predictedValues,residuals, main = "Trainning Predicted Values Vs Residuals", xlab = "Trainning Predicted Values",
     ylab = "Residuals",col=c("Red","Green"), las=1)
legend("bottomright",legend=c('Trainning Predicted Values','Residuals'),text.col=c("Red","Green") , lty=1 ,col= c("Red","Green"))

plot(dataTrainY,residuals, main = "Trainning Actual Values Vs Residuals", xlab = "Actual Values",
     ylab = "Residuals",col=c("Green","Red"), las=1)
abline(0,0)
legend("bottomright",legend=c('Actual Training Values','Residuals'),text.col=c("Green","Red") , lty=1 ,col= c("Green","Red"))

#plot of tranning Actual values vc predicted values
plot(dataTrainY, type = "l", main = "Tranning Actual values And Predicted values", 
    xlab = "Number of Samples", ylab = "Quality",  col="Green")
lines(predictedValues, col = "Red")
legend("bottomright",legend=c('Actual','Predicted'),text.col=c("Green","Red") , lty=1 ,col= c("Green","Red"))

#Scatter plot of actual test values and prediction value
plot(dataTrainY,predictedValues, main = "Actual Vs Predicted Quality", col =c("Green","Red"),xlab='Actual Quality' , ylab='Predicted Quality')
#lines(testFit, type = "l", col="Red")
legend("bottomright",legend=c('Actual','Predicted'),text.col=c("Green","Red") , lty=1 ,col= c("Green","Red"))

#Function to show variable importance
variImpor = varImp(lmFit)
plot(variImpor)

#Scoring for the validation of the model
preTestReasult = predict(lmFit, dataTestX,preProcess=c("center","scale"))
#testResidu = resid(preTestReasult)
summary(preTestReasult)

modelValues = data.frame(obs=dataTestY, pred=preTestReasult)
defaultSummary(modelValues)

#plot of test Actual values vc predicted values
plot(dataTestY, main="Actual Test Values And Predicted Values", type = "l", 
     xlab = "Number of Samples", ylab = "Quality", col="Green")
lines(preTestReasult, col = "Red")
legend("bottomright",legend=c('Actual','Predicted'),text.col=c("Green","Red") , lty=1 ,col= c("Green","Red"))

#Scatter plot of actual test values and prediction value
plot(dataTestY,preTestReasult, main = "Actual Vs Predicted Quality", col =c("Green","Red"),xlab='Actual Quality' , ylab='Predicted Quality')
#lines(testFit, type = "l", col="Red")
legend("bottomright",legend=c('Actual','Predicted'),text.col=c("Green","Red") , lty=1 ,col= c("Green","Red"))
