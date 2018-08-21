clc;

% trainSvm parameters:
% 1. FeatureClass object
% 2. Coding Style 
% 3. SVM Kernel
% 4. True/False if you wish to get a confusion matrix and accuracy
% If param4 is set to false confusionmatrix holds a NaN value 
%[classifier,confusionmatrix] = trainSVM(featureClass,'onevsone','linear',false);

googlenet_1v1_linear = SVMClassifierClass;
googlenet_1v1_linear.featureClassObject = featureClass;
googlenet_1v1_linear.coding = 'onevsone';
googlenet_1v1_linear.kernel = 'linear';
googlenet_1v1_linear.trainSVM;
googlenet_1v1_linear.testSVM;