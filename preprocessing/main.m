clc; clear;

%read the image
image = imread('check.jpg');

img_gray = rgb2gray(image);

%binarize it using Sauvola's threshold
bin = sauvola(img_gray,[3 3], 0.3);

%show the image
imshow(bin)



