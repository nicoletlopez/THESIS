clc;clear;close all;
img = imread('check.jpg');
%BWI = imcomplement(BW);
%BW2D = im2bw(BWI,0.5);
%BWT = bwmorph(BW2D,'thin',Inf),
%BWFinal = imcomplement(BWT);
%figure, imshow(BWFinal);imsave();

gray=rgb2gray(img);
bw=sauvola(gray);
figure,imshow(bw);
% remove some of the noisy edges in the mask.
bw_clean = imopen(bw, strel('disk',1));

% remove small foreground objects.
bw_clean = bwareaopen(bw_clean,45);
figure,imshow(bw_clean);

% invert the image and thin it.
bw_thin = bwmorph(imcomplement(bw_clean), 'thin', Inf);
figure,imshow(bw_thin);
