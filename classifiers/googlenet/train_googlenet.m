net = googlenet();

googlenetImageSize = net.Layers(1).InputSize;
googlenetAugmentedTrainingSet = augmentedImageDatastore(googlenetImageSize, trainingSet,'ColorPreprocessing','gray2rgb');
googlenetAugmentedTestSet = augmentedImageDatastore(googlenetImageSize, testSet, 'ColorPreprocessing', 'gray2rgb');

googlenetFeatureLayer = 'loss3-classifier';

googlenetTrainingFeatures = activations(net,googlenetAugmentedTrainingSet,...
    googlenetFeatureLayer, 'MiniBatchSize', 32, 'OutputAs', 'columns');

googlenetTestFeatures = activations(net, googlenetAugmentedTestSet, googlenetFeatureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
