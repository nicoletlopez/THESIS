clc; clear;

img=imread('sample.jpg');
imgGray=rgb2gray(img);
binarized=sauvola(imgGray);
% bounding boxes

s=regionprops(binarized,'PixelIdxList','Centroid','BoundingBox');
bboxes=cat(1,s.BoundingBox);
Iocr = insertShape(img, 'Rectangle', bboxes,'Color','blue');
imshow(Iocr);



