net = inceptionv3();

inceptionv3ImageSize = net.Layers(1).InputSize;
inceptionv3AugmentedTrainingSet = augmentedImageDatastore(inceptionv3ImageSize, trainingSet,'ColorPreprocessing','gray2rgb');
inceptionv3AugmentedTestSet = augmentedImageDatastore(inceptionv3ImageSize, testSet, 'ColorPreprocessing', 'gray2rgb');

inceptionv3FeatureLayer = 'predictions';

inceptionv3TrainingFeatures = activations(net,inceptionv3AugmentedTrainingSet,...
    inceptionv3FeatureLayer, 'MiniBatchSize', 32, 'OutputAs', 'columns');

inceptionv3TestFeatures = activations(net, inceptionv3AugmentedTestSet, inceptionv3FeatureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
