X = googlenet_training_features.';
Y = training_set_labels;

tabulation = []

% I want to start from 4 ngeighbors and end with 24 because 
% a) This takes very long
% b) 4-24 is the matlab limit

ctr = 4;
for ctr = ctr:24
    % Fit (train) the knn classifier
    googlenet_knn_classifier = fitcknn(X,Y,'NumNeighbors',ctr);
    % Get classifier's resubstitution loss - fraction of 
    % misclassifications from the predictions of the classifier
    % The classifier incorrectly predicts rloss% of the training data
    rloss = resubLoss(Mdl)

    %create a cross-validated_classifier 
    googlenet_knn_classifier_cv = crossval(googlenet_knn_classifier);

    % Get cross-validaation loss - average loss of each cross-validation model
    % when predicting on testing data
    % The classifier incorrectly predicts kfold% of test data
    kloss = kfoldloss(googlenet_knn_classifier)
    
    tabulation(ctr,1) = ctr;
    tabulation(ctr,2) = rloss;
    tabulation(ctr,3) = kloss;
end