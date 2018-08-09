pool = parpool;
options = statset('UseParallel',true);

trainingLabels = trainingSet.Labels;
template = templateSVM('KernelFunction','gaussian');
googlenet_svm_1vall_gaussian_classifer = fitcecoc(googlenetTrainingFeatures, trainingLabels,...
        'Learners',template,'Coding','onevsone',...
        'ObservationsIn','columns','Options',options);

% Evaluate
predictedLabels = predict(googlenet_svm_1vall_gaussian_classifer,googlenetTestFeatures,...
    'ObservationsIn','columns');

testLabels = testSet.Labels;

confMat = confusionmat(testLabels,predictedLabels);
confMat = bsxfun(@rdivide, confMat, sum(confMat,2));

googlenet_svm_1vall_gaussian_accuracy = mean(diag(confMat));