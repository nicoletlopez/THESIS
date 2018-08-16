% Train a 1v1 Linear SVM classifier

% Start a parallel pool (use all cores)
pool = parpool;
options = statset('UseParallel',true);

% Train the classifier
template = templateSVM('KernelFunction','linear','SaveSupportVectors',true);
vgg16_svm_1v1_linear_classifier = fitcecoc(vgg16_training_features, training_set_labels,...
    'Learners',template,'Coding','onevsone','ObservationsIn','columns',...
    'Options',options);
