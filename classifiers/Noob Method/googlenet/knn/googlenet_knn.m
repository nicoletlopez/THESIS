X = googlenet_training_features.';
Y = training_set_labels;


num_neighbors = 128;

% I want to start from 4 ngeighbors and end with 24 because 
% a) This takes very long
% b) 4-24 is the matlab limit
   % Fit (train) the knn classifier
googlenet_knn_classifier = fitcknn(X,Y,'NumNeighbors',num_neighbors);
% Get classifier's resubstitution loss - fraction of 
% misclassifications from the predictions of the classifier
% The classifier incorrectly predicts rloss% of the training data
rloss = resubLoss(googlenet_knn_classifier)

%create a cross-validated_classifier 
googlenet_knn_classifier_cv = crossval(googlenet_knn_classifier);
% Get cross-validaation loss - average loss of each cross-validation model
% when predicting on testing data
% The classifier incorrectly predicts kfold% of test data
kloss = kfoldloss(googlenet_knn_classifier)