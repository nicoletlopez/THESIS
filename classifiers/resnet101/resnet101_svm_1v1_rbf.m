pool = parpool;
options = statset('UseParallel',true);

trainingLabels = trainingSet.Labels;
template = templateSVM('KernelFunction','rbf');
resnet101_svm_1v1_rbf_classifer = fitcecoc(resnet101TrainingFeatures, trainingLabels,...
        'Learners',template,'Coding','onevsone',...
        'ObservationsIn','columns','Options',options);

% Evaluate
predictedLabels = predict(resnet101_svm_1v1_rbf_classifer,resnet101TestFeatures,...
    'ObservationsIn','columns','Options',options);

testLabels = testSet.Labels;

confMat = confusionmat(testLabels,predictedLabels);
confMat = bsxfun(@rdivide, confMat, sum(confMat,2));

resnet101_svm_1v1_rbf_accuracy = mean(diag(confMat));