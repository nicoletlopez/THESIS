clear;clc;close all;

im=imread('sample.jpg');
gray=rgb2gray(im);

bin=sauvola(gray);
imGui=im2uint8(bin);
bw = imcomplement(bin);
%imshow(bw_thin);

%{
Now, you may notice that there are some discontinuities between some letters. 
What we can do is perform a morphological opening to close these gaps. 
However, we aren't going to use this image to extract what the actual characters are. 
We are only using these to get the bounding boxes for the letters:
%}
se=strel('square',1);
im_close=imclose(bw,se);

%apply ROI-based processing to improve results
blobAnalyzer=vision.BlobAnalysis('MaximumCount',1000000);

% Run the blob analyzer to find connected components and their statistics.
[area, centroids, roi] = step(blobAnalyzer, im_close);
%withoutConstraint=insertShape(imGui, 'rectangle', roi,'Color','blue');
%figure,imshow(withoutConstraint);

areaConstraint=area>20;
roi = double(roi(areaConstraint, :));



% Compute the aspect ratio.
width  = roi(:,3);
height = roi(:,4);
aspectRatio = width ./ height;

% An aspect ratio between 0.25 and 1 is typical for individual characters
% as they are usually not very short and wide or very tall and skinny.
roi = roi(aspectRatio > 0.2 & aspectRatio < 2 ,:);

img = insertShape(imGui, 'rectangle', roi,'Color','blue');
figure,imshow(img);
%{
Now, you'd call regionprops like this to find all of the bounding boxes in the image 
(after applying morphology):
%}
%{
s=regionprops(im_close,'BoundingBox');
bb = round(reshape([s.BoundingBox], 4, []).');
noConstraint=insertShape(im2uint8(bin),'Rectangle',bb,'Color','blue');
figure,imshowpair(noConstraint,img,'montage');
%}
