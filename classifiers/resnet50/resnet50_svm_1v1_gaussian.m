pool = parpool;
options = statset('UseParallel',true);

trainingLabels = trainingSet.Labels;
template = templateSVM('KernelFunction','gaussian');
resnet50_svm_1v1_gaussian_classifer = fitcecoc(resnet50TrainingFeatures, trainingLabels,...
        'Learners',template,'Coding','onevsone',...
        'ObservationsIn','columns','Options',options);

% Evaluate
predictedLabels = predict(resnet50_svm_1v1_gaussian_classifer,resnet50TestFeatures,...
    'ObservationsIn','columns');

testLabels = testSet.Labels;

confMat = confusionmat(testLabels,predictedLabels);
confMat = bsxfun(@rdivide, confMat, sum(confMat,2));

resnet50_svm_1v1_gaussian_accuracy = mean(diag(confMat));