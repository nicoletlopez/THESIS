pool = parpool;
options = statset('UseParallel',true);

trainingLabels = trainingSet.Labels;
template = templateSVM('KernelFunction','linear');
resnet101_svm_1vall_linear_classifer = fitcecoc(resnet101TrainingFeatures, trainingLabels,...
        'Learners',template,'Coding','onevsone',...
        'ObservationsIn','columns','Options',options);

% Evaluate
predictedLabels = predict(resnet101_svm_1vall_linear_classifer,resnet101TestFeatures,...
    'ObservationsIn','columns');

testLabels = testSet.Labels;

confMat = confusionmat(testLabels,predictedLabels);
confMat = bsxfun(@rdivide, confMat, sum(confMat,2));

resnet101_svm_1vall_linear_accuracy = mean(diag(confMat));