pool = parpool;
options = statset('UseParallel',true);

trainingLabels = trainingSet.Labels;
template = templateSVM('KernelFunction','linear');
vgg16_svm_1v1_gaussian_classifer = fitcecoc(vgg16TrainingFeatures, trainingLabels,...
        'Learners',template,'Coding','onevsone',...
        'ObservationsIn','columns','Options',options);

% Evaluate
predictedLabels = predict(vgg16_svm_1v1_gaussian_classifer,vgg16TestFeatures,...
    'ObservationsIn','columns');

testLabels = testSet.Labels;

confMat = confusionmat(testLabels,predictedLabels);
confMat = bsxfun(@rdivide, confMat, sum(confMat,2));

vgg16_svm_1v1_gaussian_accuracy = mean(diag(confMat));