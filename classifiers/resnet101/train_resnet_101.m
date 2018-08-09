net = resnet101();

resnet101ImageSize = net.Layers(1).InputSize;
resnet101AugmentedTrainingSet = augmentedImageDatastore(resnet101ImageSize, trainingSet,'ColorPreprocessing','gray2rgb');
resnet101AugmentedTestSet = augmentedImageDatastore(resnet101ImageSize, testSet, 'ColorPreprocessing', 'gray2rgb');

resnet101FeatureLayer = 'fc1000';

resnet101TrainingFeatures = activations(net,resnet101AugmentedTrainingSet,...
    resnet101FeatureLayer, 'MiniBatchSize', 32, 'OutputAs', 'columns');

resnet101TestFeatures = activations(net, resnet101AugmentedTestSet, resnet101FeatureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');

