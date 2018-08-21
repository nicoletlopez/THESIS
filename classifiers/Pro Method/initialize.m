clc;

imageSetObject = ImageSetClass;
imageSetObject.trainingDatastore = '/home/pam/Documents/OOP/datasets/hsf_dataset_resized_1400_cropped';
imageSetObject.testDatastore = '/home/pam/Documents/OOP/datasets/extracted_extended';

featureClass = FeatureClass;
featureClass.net = googlenet;
featureClass.featureLayer = 'loss3-classifier';
featureClass.imageSetClass = imageSetObject;
featureClass.generateTrainingFeatures;
featureClass.generateTestFeatures;

% As we no longer need the class instance imageSetObject we may as well
% clear it to free up system memory
clear imageSetObject;

% trainSvm parameters:
% 1. FeatureClass object
% 2. Coding Style 
% 3. SVM Kernel
% 4. True/False if you wish to get a confusion matrix and accuracy
%[classifier,confusionMatrix] = trainSVM(featureClass,'onevsone','gaussian',false);