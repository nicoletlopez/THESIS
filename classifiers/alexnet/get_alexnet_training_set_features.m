% Use this ONLY if you have a training_set that you want to transform into a feature vector
net = alexnet;

% Get the required input size of the neural net
alexnet_image_size = net.Layers(1).InputSize;

% The augmentedImageDatastore is a tool for batch processing of images. For example,
% a large amount of images needs to be resized (according to the first argument)
alexnet_augmented_training_set = augmentedImageDatastore(alexnet_image_size,...
    training_set, 'ColorPreprocessing', 'gray2rgb');

% Feature layers are the neural net layers where we decide to extract their data
% as 'features' They are unique per CNN
alexnet_feature_layer = 'fc7';

% Get the feature vectors of each image within the datastore
% The output is a matrix with each column corresponding to a single picture's feature
% vectors
alexnet_training_features = activations(net,alexnet_augmented_training_set,...
    alexnet_feature_layer,'MiniBatchSize',32,'OutputAs','columns');