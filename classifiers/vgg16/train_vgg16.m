net = vgg16();

vgg16ImageSize = net.Layers(1).InputSize;
vgg16AugmentedTrainingSet = augmentedImageDatastore(vgg16ImageSize, trainingSet,'ColorPreprocessing','gray2rgb');
vgg16AugmentedTestSet = augmentedImageDatastore(vgg16ImageSize, testSet, 'ColorPreprocessing', 'gray2rgb');

vgg16FeatureLayer = 'fc7';

vgg16TrainingFeatures = activations(net,vgg16AugmentedTrainingSet,...
    vgg16FeatureLayer, 'MiniBatchSize', 32, 'OutputAs', 'columns');

vgg16TestFeatures = activations(net, vgg16AugmentedTestSet, vgg16FeatureLayer, ...
    'MiniBatchSize', 32, 'OutputAs', 'columns');

