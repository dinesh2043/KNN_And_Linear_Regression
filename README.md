## KNN And Linear Regression

### Exercise Work 2: (Using White Wine Dataset)
### Task 1:
### KNN Algorithm:
K Nearest Neighbour (KNN) is very simple algorithm which works very well in practice. It is one of the top 10 data mining algorithms and it is used without making any assumptions on the underlying data distribution. It is also known as lazy algorithm because it doesn’t use training data point to do data generalization but it uses instance-based learning. KNN is quite efficient while training the model because it does not learn the model out of training data but it memorizes the training data. In KNN dataset is a model and it uses these training data in the new instances for predicting the result while the algorithm is tested. It makes the decision based on the entire training dataset. It can be used in the multidimensional dataset to find the solutions for both classification and regression problems. The main weakness of this algorithm is that it works well only for the right value of k of a given dataset. [1]
### KNN Regression:
KNN algorithm can also be used to predict the outcome of a continuous variables. This algorithm uses a weighted average of k nearest neighbours and computes the Euclidean distance from the input value to labelled value. Root mean square error (RMSE) and mean square error (R2) are used to select the optimal number of k while doing cross-validation of the purposed model. [1]
### K-Fold Cross-Validation:
In k fold cross-validation the dataset is randomly divided into K equal size subset without overlaps called folds. In each iteration of k-fold cross-validation it uses one fold for testing and uses k-1 folds for training. It is the most efficient technique to find the optimal value of k for KNN algorithm. In k-fold cross-validation it is a quite common practice to choose 10 or 5 as number of folds, which is done to reduce the training and testing performance for cross-validation. It is much faster then leave-one-out validation technique.
It is my individual exercise work and I have even student number so that I have used white wine dataset for both tasks. Both of the task were done installing caret package in RStudio because this package had better documentation then other available packages.
After importing the dataset to the studio I have used createDataPartition() function available in caret library to split the dataset randomly into two half, where tanning data contains 80% and testing data contains remaining 20% samples. This was done to distribute data uniformly in random order to prepare the better test and train dataset. The full implementation of the function can be seen in the following figure;
   
#### Figure 1: Dataset Partition into train and test data
Then the uniformly distributed training and testing dataset was normalized using z-score normalization, using preProcess () function of caret library.  The following code snippet will illustrate the process;
 
#### Figure 2: Training and testing dataset normalization
After the data partition and normalization, both test and train dataset were ready for model creation using K-NN regression to predict the wine quality. To create a model knnreg() method was used by supplying the necessary attributes. The following code snippet will illustrate the model building process;
 
#### Figure 3: K-NN Regression model creation
Then the model was ready for testing using test dataset. To do that predict () function of caret library was used. In the following section we can see the code implementation of the process;
 
#### Figure 4: Predict function implementation 
Then the model performance was checked using defaultSummary () method, which showed that RMSE was equal to 0.7277 and R2 was equal to 0.3073. These two values are pretty good considering the performance of the model.  In the following code the use of the function can be seen;
 
Figure 5: Model performance test
When the model was tested with the test data set its prediction was quite good, almost all the predicted value were within the range of actual quality values. Following figure illustrate the actual quality value of the test data and the predicted value of the model;
 
#### Figure 6: Actual and predicted quality values of test dataset
As we proceed for the cross-validation of the result, 10-fold cross-validation technique was used to obtain the optimal value of nearest neighbour for the model. To get the optimal value of k the complete dataset was randomly divided in 10 folds and in each iteration one fold was tested against k-1 folds. To obtain better value of k the whole dataset was pre-processed and train control was used to train for k-fold validation. Following code snippet shows its implementation;
  
#### Figure 7: 10-fold cross-validation implementation
The output of the cross-validation technique showed that 11 is the optimal value of k which had RMSE value equal to 0.7035 and R2 value equal to 0.371. The output of cross-validation can be seen in the following figure;
   
#### Figure 8: Output of cross-validation
The output values of the cross-validation was plotted using number of nearest neighbours and their corresponding RMSE value. The optimal value of k is chosen according to the corresponding lowest value of RMSE. The results of cross-validation can be seen in the following plot; 

#### Figure 9: Number of neighbour’s vs accuracy of CV
Similarly the predicted values and its residuals are plotted to show the distribution of the prediction done by cross-validation technique used. The results shows that the distribution was uniform and cross-validation has well performed, which can be seen in the following figure; 

#### Figure 10: Predicted values vs residuals
To make the additional argument that the 10-fold cross-validation was the good choice for cross validation the results of prediction and the actual values were plotted, which showed that there was a good fit in the result. Following plot illustrates the actual quality values in the dataset and the predicted result of the quality;
 
#### Figure 11: Plot for actual and predicted quality of CV
### Results of K-NN Regression: 
While comparing the observations of 10-fold cross-validation and the actual model created there is not so much variance in the accuracy of the predicted value. As CV result are more accurate but it is not as efficient as the presented model. While comparing these results of CV and actual model testing there is a variance in RMSE with 0.0242 and in R2 with -0.0644 which is very small value. Since, there is very low variance in the accuracy of the actual model it might be the efficient solution for this k-NN regression problem. 


 

### Task 2:
### Linear Regression:
It is the most simple and commonly used technique for predictive analysis. It is used to describe data and to explain the relationship between one dependent variable and one or more independent variables. The main task of the regression analysis is to fit single line in a scatter plot. Simply linear regression of one dependent and one independent variable is defined by the formula y = c + b*x, where y is dependent variable, b is a regression coefficients and x is an independent variable. Linear regression is conducted by analysing the correlation of the data, model estimation and cross validation to estimate the usefulness of the model. [2]
All the process of data partition and defining the test and train dataset are similar to K-NN regression. Process of building a model is little bit different where train () function was used with pre-processing and method was selected to be “lm”. Code snippet shown below shows the process of implementation;
  
#### Figure 12: Creation of the linear model
When the model was created its accuracy was checked using summary function, where RMSE was equal to 0.7535 and R2 was equal to 0.2828. To check the model performance the scatter plot of predicted value vs residual was drawn, which has shown a uniform distribution. In the following figure we can see the results;
 
#### Figure 13: Scatter plot of predicted values vs residuals
Similarly the scatter plot of the actual value verses residual was drawn with the line to check the proportion of distribution of the residual values. Results can be seen in the following figure;   
 
#### Figure 14: Scatter plot of actual value vs residuals
After that the plot was drawn to show the actual value and predicted values of train dataset, and its results can be seen in the following figure;
 
#### Figure 15: Scatter plot of actual and predicted quality value
Since, linear regression is used to define and find the relationship between the dependent variables. This observation shows that fixed acidity had strong relation with quality, where total sulphur dioxide has no relation with quality. In the following figure it shows the importance of the all attributes as percentage value in this linear regression model;
  
#### Figure 16: Percentage of variable importance
Then the model is tested with test data to find out scoring for the validation of the model. It is done using predict () function by providing the processed test dataset to generate the prediction values. According to test results RMSE was equal to 0.7439 and R2 was equal to 0.2756 which was better than the train result of the model. Following code snippet shows the implementation of these methods;
  
#### Figure 17: Model test implementation
Since, we have obtained better RMSE and R2 in the test result if we check the plot with actual and predicted values slight difference can be seen. In the following figure we can see the comparison between the actual quality values of test data and the predicted values by the model;
  
#### Figure 18: Test actual and predicted quality values
After the linear model was ready it was the time for cross-validation of the model, where 10-fold cross-validation technique was used to have a better evaluation. Its implementation was almost similar to k-NN but here “lm” method and Rsquard matric was used. The implementation of the method can be seen in the following figure;
 
#### Figure 19: 10-fold cross-validation for linear regression
When the cross-validation was complete its output was checked, which can be seen in the following figure to have its better understanding of the results;
 
#### Figure 20: Output of the cross-validation
### Results of Linear Regression:
If we check the accuracy of prediction in 10-fold cross-validation and the test result of our model there is quite a little bit of difference -0.0092 in RMSE and 0.0024 in R2. With these result we can say that model is optimal and as efficient as cross validation according to its performance.
### Conclusions
According to the observation of these two methods of regression for predictive analysis, performance of K-NN regression was better than linear regression. It was also because the optimal value of k was obtained by the 10-fold cross validation of nearest neighbours. That optimal value was used in the K-NN regression model to increase its efficiency and performance. On the other hand linear model performance was as good as the performance of 10-fold cross validation of linear regression. But according to the results obtained during the observation clearly showed that K-NN regression with optimal value of k has much better performances. The results of the performance of these two method were good because of random uniform distribution of the dataset for training, testing and cross-validation. Also all the dataset used in the model and cross-validation were normalized using z-score normalization, which have contributed for the final results. Both the model was evaluated on the basis of the available wine dataset and its results might be slightly different when the model is tested with new dataset which have not been used for testing and training of the model. With these claims I would like to conclude that the two model presented in this exercise are the optimal solution according to their prediction and performance.
          
 

### References
[1] Name, "A detailed introduction to k-nearest neighbor (KNN) algorithm," God, Your Book Is Great !!, 2010. [Online]. Available: https://saravananthirumuruganathan.wordpress.com/2010/05/17/a-detailed-introduction-to-k-nearest-neighbor-knn-algorithm/. Accessed: Dec. 11, 2016. 
[2] S. S. 2016, "What is linear regression?," Statistics Solutions, 2016. [Online]. Available: http://www.statisticssolutions.com/what-is-linear-regression/. Accessed: Dec. 11, 2016.     
