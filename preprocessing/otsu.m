clc; clear;

image = imread('check_no_edge.jpg');
level = graythresh(image);
otsu_bin = imbinarize(image,level);

% imshowpair(image,otsu_bin,'montage');
imshowpair(image,otsu_bin,'montage');