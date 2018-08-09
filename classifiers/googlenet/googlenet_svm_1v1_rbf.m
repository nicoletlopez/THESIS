pool = parpool;
options = statset('UseParallel',true);

trainingLabels = trainingSet.Labels;
template = templateSVM('KernelFunction','rbf');
googlenet_svm_1v1_rbf_classifer = fitcecoc(googlenetTrainingFeatures, trainingLabels,...
        'Learners',template,'Coding','onevsone',...
        'ObservationsIn','columns','Options',options);

% Evaluate
predictedLabels = predict(googlenet_svm_1v1_rbf_classifer,googlenetTestFeatures,...
    'ObservationsIn','columns');

testLabels = testSet.Labels;

confMat = confusionmat(testLabels,predictedLabels);
confMat = bsxfun(@rdivide, confMat, sum(confMat,2));

googlenet_svm_1v1_rbf_accuracy = mean(diag(confMat));