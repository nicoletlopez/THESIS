% Use this ONLY if you have a training_set that you want to transform into a feature vector
net = googlenet;

% Get the required input size of the neural net
googlenet_image_size = net.Layers(1).InputSize;

% The augmentedImageDatastore is a tool for batch processing of images. For example,
% a large amount of images needs to be resized (according to the first argument)
googlenet_augmented_training_set = augmentedImageDatastore(googlenet_image_size,...
    training_set, 'ColorPreprocessing', 'gray2rgb');

% Feature layers are the neural net layers where we decide to extract their data
% as 'features' They are unique per CNN
googlenet_feature_layer = 'loss3-classifier';

% Get the feature vectors of each image within the datastore
% The output is a matrix with each column corresponding to a single picture's feature
% vectors
googlenet_training_features = activations(net,googlenet_augmented_training_set,...
    googlenet_feature_layer,'MiniBatchSize',32,'OutputAs','columns',...
    'ExecutionEnvironment','gpu');

load chirp
sound(y,Fs)