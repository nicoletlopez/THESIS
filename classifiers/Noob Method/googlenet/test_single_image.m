clc;
net = googlenet;

googlenet_image_size = net.Layers(1).InputSize;
googlenet_feature_layer = 'loss3-classifier';

image = imread('hsf_0_00000.png');
image = imbinarize(image);
image = im2uint8(image);
imshow(image)

image = augmentedImageDatastore(googlenet_image_size,image,'ColorPreprocessing','gray2rgb');

image_features = activations(net,image,googlenet_feature_layer,'OutputAs','columns');

label = predict(googlenet_svm_1v1_linear_classifier,image_features,'ObservationsIn','columns')