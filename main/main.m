clc; clear;

% PREPROCESSING
image = imread('binarized_check_no_edge.png');

% Return the grayscaled image after checking
img_gray = safe_grayscale(image);

% Binarize using Sauvola's threshold
bin = sauvola(img_gray,[3 3], 0.34);

%show the image
figure;
imshow(bin);
title('Binarized Image');

% END PREPROCESSING

% SEGMENTATION
window_sliding(bin);

