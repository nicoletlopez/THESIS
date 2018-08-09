net = vgg19();

vgg19ImageSize = net.Layers(1).InputSize;
vgg19AugmentedTrainingSet = augmentedImageDatastore(vgg19ImageSize, trainingSet,'ColorPreprocessing','gray2rgb');
vgg19AugmentedTestSet = augmentedImageDatastore(vgg19ImageSize, testSet, 'ColorPreprocessing', 'gray2rgb');

vgg19FeatureLayer = 'fc7';

vgg19TrainingFeatures = activations(net,vgg19AugmentedTrainingSet,...
    vgg19FeatureLayer, 'MiniBatchSize', 32, 'OutputAs', 'columns');

vgg19TestFeatures = activations(net, vgg19AugmentedTestSet, vgg19FeatureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');

