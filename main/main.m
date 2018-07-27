clc; clear;

% Preprocessing
image = imread('binarized_check_no_edge.png');

% Return the grayscaled image after checking
img_gray = safe_grayscale(image);

% Binarize using Sauvola's threshold
bin = sauvola(img_gray,[3 3], 0.34);

%show the image
imshow(bin)
