pool = parpool;
options = statset('UseParallel',true);

trainingLabels = trainingSet.Labels;
template = templateSVM('KernelFunction','rbf');
vgg19_svm_1vall_rbf_classifer = fitcecoc(vgg19TrainingFeatures, trainingLabels,...
        'Learners',template,'Coding','onevsone',...
        'ObservationsIn','columns','Options',options);

% Evaluate
predictedLabels = predict(vgg19_svm_1vall_rbf_classifer,vgg19TestFeatures,...
    'ObservationsIn','columns');

testLabels = testSet.Labels;

confMat = confusionmat(testLabels,predictedLabels);
confMat = bsxfun(@rdivide, confMat, sum(confMat,2));

vgg19_svm_1vall_rbf_accuracy = mean(diag(confMat));