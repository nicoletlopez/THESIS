% Evaluate the classifier by using it to make predictions on the test_set

pool = parpool;
options = statset('UseParallel',true);
% For each item in the training_set, the predict() function outputs a 'label' 
% or its designated classification
% We use the feature vectors of each image in the training set as input 
% of the prediction machine
predicted_labels = predict(googlenet_svm_1v1_linear_classifier, googlenet_test_features,...
    'ObservationsIn','columns','Options',options);

% Actual vs Predicted classifications
confusion_matrix = confusionmat(test_set_labels, predicted_labels);
% Turn the confusion_matrix values into percentage form
confusion_matrix = bsxfun(@rdivide, confusion_matrix, sum(confusion_matrix,2));

% Get the mean accuracy
accuracy = mean(diag(confusion_matrix))

load chirp
sound(y,Fs)