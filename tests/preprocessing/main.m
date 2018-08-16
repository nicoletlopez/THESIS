clc; clear;

%read the image
image = imread('check_no_edge.jpg');

% Default
img_gray = rgb2gray(image);

% Loop through all the images to know if it's already in binary format
% (attempting to binarize a B&W image throws an error)
% Note: please turn into a helper function later
% [rows,columns,numberOfColorChannels] = size(image);
% if numberOfColorChannels > 1
%      img_gray = rgb2gray(image);
% else
%     img_gray = image;
% end


%binarize it using Sauvola's threshold
bin = sauvola(img_gray,[3 3], 0.34);

%show the image
imshowpair(image,bin,'montage')
