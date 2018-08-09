pool = parpool;
options = statset('UseParallel',true);

trainingLabels = trainingSet.Labels;
template = templateSVM('KernelFunction','linear');
resnet50_svm_1vall_linear_classifer = fitcecoc(resnet50TrainingFeatures, trainingLabels,...
        'Learners',template,'Coding','onevsall',...
        'ObservationsIn','columns','Options',options);

% Evaluate
predictedLabels = predict(resnet50_svm_1vall_linear_classifer,resnet50TestFeatures,...
    'ObservationsIn','columns','Options',options);

testLabels = testSet.Labels;

confMat = confusionmat(testLabels,predictedLabels);
confMat = bsxfun(@rdivide, confMat, sum(confMat,2));

resnet50_svm_1vall_linear_accuracy = mean(diag(confMat));