clc; clear;

% Load training and test data using |imageDatastore|.
%syntheticDir   = fullfile(toolboxdir('vision'), 'visiondata','digits','synthetic');
%handwrittenDir = fullfile(toolboxdir('vision'), 'visiondata','digits','handwritten');
syntheticDir = 'Fnt';
handwrittenDir = 'Hnd';

% |imageDatastore| recursively scans the directory tree containing the
% images. Folder names are automatically used as labels for each image.
trainingSet = imageDatastore(syntheticDir,   'IncludeSubfolders', true, 'LabelSource', 'foldernames');
testSet     = imageDatastore(handwrittenDir, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

%count of each class sample
countEachLabel(trainingSet)
countEachLabel(testSet)

%show some of the training set
figure;

subplot(2,3,1);
imshow(trainingSet.Files{102});

subplot(2,3,2);
imshow(trainingSet.Files{304});

subplot(2,3,3);
imshow(trainingSet.Files{809});

subplot(2,3,4);
imshow(testSet.Files{13});

subplot(2,3,5);
imshow(testSet.Files{37});

subplot(2,3,6);
imshow(testSet.Files{97});

% Show pre-processing results
exTestImage = readimage(testSet,37);
processedImage = imbinarize(rgb2gray(exTestImage));

figure;

subplot(1,2,1)
imshow(exTestImage)

subplot(1,2,2)
imshow(processedImage)