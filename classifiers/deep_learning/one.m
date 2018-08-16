root_folder = fullfile('/home','pam','Documents','FINAL',...
    'hsf_dataset_resized_1400_cropped');

imds = imageDatastore(root_folder,'IncludeSubfolders',true,...
    'LabelSource','foldernames','ReadFcn',@resize_image);

label_count = countEachLabel(imds)

% figure;
% perm = randperm(10000,20);
% for i = 1:20
%     subplot(4,5,i);
%     imshow(imds.Files{perm(1)});
% end

[test_set,pholder] = splitEachLabel(test_set,1);
test_set = augmentedImageDatastore([28 28], test_set, 'ColorPreprocessing','gray2rgb');


% file_proportion = 0.80;
% [training_set,test_set] = splitEachLabel(imds,file_proportion)
training_set = splitEachLabel(imds,1400);

% Define network architecture
layers = [
    imageInputLayer([28 28 3])
    
    convolution2dLayer(3,8,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,16,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    maxPooling2dLayer(2,'Stride',2)
    
    convolution2dLayer(3,32,'Padding',1)
    batchNormalizationLayer
    reluLayer
    
    fullyConnectedLayer(47)
    softmaxLayer
    classificationLayer];

% Specify trining options
options = trainingOptions('sgdm',...
    'MaxEpochs',4,...
    'ValidationData',test_set,...
    'ValidationFrequency',30,...
    'Verbose', false,...
    'Plots','training-progress')

net = trainNetwork(training_set,layers,options);

YPred = classify(net,test_set);
YValidation = test_set_labels;

accuracy = sum(YPred == YValidation)/numel(YValidation)