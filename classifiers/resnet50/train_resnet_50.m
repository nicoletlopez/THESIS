net = resnet50();

resnet50ImageSize = net.Layers(1).InputSize;
resnet50AugmentedTrainingSet = augmentedImageDatastore(resnet50ImageSize, trainingSet,'ColorPreprocessing','gray2rgb');
resnet50AugmentedTestSet = augmentedImageDatastore(resnet50ImageSize, testSet, 'ColorPreprocessing', 'gray2rgb');

resnet50FeatureLayer = 'fc1000';

resnet50TrainingFeatures = activations(net,resnet50AugmentedTrainingSet,...
    resnet50FeatureLayer, 'MiniBatchSize', 32, 'OutputAs', 'columns');

resnet50TestFeatures = activations(net, resnet50AugmentedTestSet, resnet50FeatureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');
