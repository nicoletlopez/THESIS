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