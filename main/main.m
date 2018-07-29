clc; clear;

% PREPROCESSING
image = imread('check_no_edge.jpg');

% Return the grayscaled image after checking
img_gray = safe_grayscale(image);

% Binarize using Sauvola's threshold
window_step = [3 3];
threshold = 0.34;
bin = sauvola(img_gray,window_step, threshold);

%show the image
figure;
imshow(bin);
figure_title = strcat('Binarized Image - SV');
title(figure_title);

% END PREPROCESSING

% SEGMENTATION
bin = im2uint8(bin);
window_sliding(bin);

