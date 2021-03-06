clear all;
load('classifNormalized');
lambda = 0.5;
alpha = 0.1;
beta = penLogisticRegression(myY_train, [myX_train,abs(myX_train)], alpha,lambda,10000);

predictions = sigmoid([myX_test,abs(myX_test)] * beta);

csvwrite('predictions_classification.csv',predictions);