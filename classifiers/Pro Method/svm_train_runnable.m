clc;

% trainSvm parameters:
% 1. FeatureClass object
% 2. Coding Style 
% 3. SVM Kernel
% 4. True/False if you wish to get a confusion matrix and accuracy
% If param4 is set to false confusionmatrix holds a NaN value 
[classifier,confusionmatrix] = trainSVM(featureClass,'onevsone','linear',false);