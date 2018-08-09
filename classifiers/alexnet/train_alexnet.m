net = alexnet();

alexnetImageSize = net.Layers(1).InputSize;
alexnetAugmentedTrainingSet = augmentedImageDatastore(alexnetImageSize, trainingSet,'ColorPreprocessing','gray2rgb');
alexnetAugmentedTestSet = augmentedImageDatastore(alexnetImageSize, testSet, 'ColorPreprocessing', 'gray2rgb');

alexnetFeatureLayer = 'fc7';

alexnetTrainingFeatures = activations(net,alexnetAugmentedTrainingSet,...
    alexnetFeatureLayer, 'MiniBatchSize', 32, 'OutputAs', 'columns');

alexnetTestFeatures = activations(net, alexnetAugmentedTestSet, alexnetFeatureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');

