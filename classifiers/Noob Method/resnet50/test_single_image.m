
net = resnet50;

resnet50_image_size = net.Layers(1).InputSize;
resnet50_feature_layer = 'fc1000';

image = imread('extract150.png');
% image = im2uint8(image);
imshow(image);

image = augmentedImageDatastore(resnet50_image_size,image,'ColorPreprocessing','gray2rgb');

image_features = activations(net,image,resnet50_feature_layer,'OutputAs','columns');

label = predict(resnet50_svm_1v1_linear_classifier,image_features,'ObservationsIn','columns')