pool = parpool;
options = statset('UseParallel',true);

trainingLabels = trainingSet.Labels;
template = templateSVM('KernelFunction','gaussian');
inceptionv3_svm_1v1_gaussian_classifer = fitcecoc(inceptionv3TrainingFeatures, trainingLabels,...
        'Learners',template,'Coding','onevsone',...
        'ObservationsIn','columns','Options',options);

% Evaluate
predictedLabels = predict(inceptionv3_svm_1v1_gaussian_classifer,inceptionv3TestFeatures,...
    'ObservationsIn','columns');

testLabels = testSet.Labels;

confMat = confusionmat(testLabels,predictedLabels);
confMat = bsxfun(@rdivide, confMat, sum(confMat,2));

inceptionv3_svm_1v1_gaussian_accuracy = mean(diag(confMat));