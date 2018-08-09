pool = parpool;
options = statset('UseParallel',true);

trainingLabels = trainingSet.Labels;
template = templateSVM('KernelFunction','rbf');
vgg16_svm_1v1_rbf_classifer = fitcecoc(vgg16TrainingFeatures, trainingLabels,...
        'Learners',template,'Coding','onevsone',...
        'ObservationsIn','columns','Options',options);

% Evaluate
predictedLabels = predict(vgg16_svm_1v1_rbf_classifer,vgg16TestFeatures,...
    'ObservationsIn','columns','Options',options);

testLabels = testSet.Labels;

confMat = confusionmat(testLabels,predictedLabels);
confMat = bsxfun(@rdivide, confMat, sum(confMat,2));

vgg16_svm_1v1_rbf_accuracy = mean(diag(confMat));