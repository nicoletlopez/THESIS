clc;

net = alexnet;

alexnet_image_size = net.Layers(1).InputSize;
alexnet_feature_layer = 'loss3-classifier';

image = imread('hsf_1_00546.png');
image = imresize(image,0.25);
% image = im2uint8(image);
imshow(image);

image = augmentedImageDatastore(alexnet_image_size,image,'ColorPreprocessing','gray2rgb');

image_features = activations(net,image,alexnet_feature_layer,'OutputAs','columns');

label = predict(alexnet_svm_1v1_linear_classifier,image_features,'ObservationsIn','columns')