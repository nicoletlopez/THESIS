
net = vgg16;

vgg16_image_size = net.Layers(1).InputSize;
vgg16_feature_layer = 'loss3-classifier';

image = imread('hsf_0_00004_cropped.png');
% image = im2uint8(image);
imshow(image);

image = augmentedImageDatastore(vgg16_image_size,image,'ColorPreprocessing','gray2rgb');

image_features = activations(net,image,vgg16_feature_layer,'OutputAs','columns');

label = predict(vgg16_svm_1v1_linear_classifier,image_features,'ObservationsIn','columns')