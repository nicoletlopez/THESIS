pool = parpool;
options = statset('UseParallel',true);

trainingLabels = trainingSet.Labels;
template = templateSVM('KernelFunction','gaussian');
inceptionv3_svm_1vall_gaussian_classifer = fitcecoc(inceptionv3TrainingFeatures, trainingLabels,...
        'Learners',template,'Coding','onevsall',...
        'ObservationsIn','columns','Options',options);

% Evaluate
predictedLabels = predict(inceptionv3_svm_1vall_gaussian_classifer,inceptionv3TestFeatures,...
    'ObservationsIn','columns','Options',options);

testLabels = testSet.Labels;

confMat = confusionmat(testLabels,predictedLabels);
confMat = bsxfun(@rdivide, confMat, sum(confMat,2));

inceptionv3_svm_1vall_gaussian_accuracy = mean(diag(confMat));