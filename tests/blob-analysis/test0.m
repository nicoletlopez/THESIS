clear;clc;close all;

disp('----------------START----------------');

%image file name
[file,path]=uigetfile('*.png;*.jpg;*.tif;*.tiff');
filePath=fullfile(path,file);

info=imfinfo(filePath);

disp('Reading image...');
%read file
im=imread(filePath);
%convert to rgb
%im=im(:,:,[1 1 1]);
%uint16
%im=im2uint16(im);

%add noise

disp('Adding noise to image...');
%im=imnoise(im,'speckle');

%figure('Name','Image with Noise'),imshow(im);

%{

disp('Grayscaling image...');
gray=rgb2gray(im);
figure('Name','Grayscaled Image'),imshow(gray);

disp('Binarizing image using Sauvolas threshold...');
%bin=imbinarize(gray);
bin=sauvola(gray,[3 3],0.5);
figure('Name','Binarized Image'),imshow(bin);
%}
%lol
bin=im;
imGui=im2uint8(bin);
bw = imcomplement(bin);
%imshow(bw_thin);

%{
Now, you may notice that there are some discontinuities between some letters. 
What we can do is perform a morphological opening to close these gaps. 
However, we aren't going to use this image to extract what the actual characters are. 
We are only using these to get the bounding boxes for the letters:
%}

%se=strel('square',1);
%im_close=imclose(bw,se);
%se=strel('line',11,90);
%se = strel('disk',-2);
%bw=imdilate(bw,se);
%bw=bwmorph(bw,'skel',Inf);
%figure,imshow(bw);
%apply ROI-based processing to improve results
blobAnalyzer=vision.BlobAnalysis('MaximumCount',99999999);

% Run the blob analyzer to find connected components and their statistics.
%[area, centroids, roi] = step(blobAnalyzer, im_close);
[area, centroids, roi] = step(blobAnalyzer, bw);



%withoutConstraint=insertShape(imGui, 'rectangle', roi,'Color','blue');
%figure('Name','Character segmentation without constraints'),
%imshow(withoutConstraint);

areaConstraint=area>20;

%Keep regions that meet the area constraint
%roi = double(roi(areaConstraint, :));

% Compute the aspect ratio.
width  = roi(:,3);
height = roi(:,4);
aspectRatio = width ./ height;

% An aspect ratio between 0.25 and 1 is typical for individual characters
% as they are usually not very short and wide or very tall and skinny.
%roi = roi(aspectRatio > 0.2 & aspectRatio < 2 ,:);


disp('Segmenting characters in image...');
img = insertShape(imGui, 'rectangle', roi,'Color','red','LineWidth',5);

figure('Name','Character segmentation with constraints'),imshow(img);
%figure,imshow(img);


disp('----------------END----------------');


