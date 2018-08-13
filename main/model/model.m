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

%im=im2int16(im);
%add noise
%{
disp('Adding noise to image...');
im=imnoise(im,'speckle');
%}
%figure('Name','Image with Noise'),imshow(im);



%disp('Grayscaling image...');
%gray=rgb2gray(im);
%figure('Name','Grayscaled Image'),imshow(gray);

%disp('Binarizing image using Sauvolas threshold...');
%bin=sauvola(gray);
%figure('Name','Binarized Image'),imshow(bin);


%lol
bin=im;
imGui=im2uint8(bin);
bw = imcomplement(bin);
%imshow(bw_thin);

%se=strel('square',1);
%im_close=imclose(bw,se);
%se=strel('line',11,90);
%se = strel('disk',-2);
%bw=imdilate(bw,se);
%bw=bwmorph(bw,'skel',Inf);
%figure,imshow(bw);

marker = imerode(bw, strel('line',10,0));
bw = imreconstruct(marker, bw);
figure,imshow(bw);

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
roi = double(roi(areaConstraint, :));

% Compute the aspect ratio.
width  = roi(:,3);
height = roi(:,4);
aspectRatio = width ./ height;

% An aspect ratio between 0.25 and 1 is typical for individual characters
% as they are usually not very short and wide or very tall and skinny.
roi = roi(aspectRatio > 0.2 & aspectRatio < 2 ,:);


disp('Segmenting characters in image...');
img = insertShape(imGui, 'rectangle', roi,'Color','blue');

%figure('Name','Character segmentation with constraints'),imshow(img);
figure,imshow(img);




%{
%number of boxes
roiCount=numel(roi(:,1));

n=99999;
l=1;
rand=randperm(n);

disp('Cropping and saving images...');
folderName=sprintf('%s-extracts-%d',file,rand(1));
%folderName=strcat(info.Filename,int2str(info.FileSize));
export_fig(sprintf('segmented-%s.pdf',file),'-pdf');
%saveas(img,sprintf('segmented-%s.pdf',file));
%print(img,sprintf('segmented-%s.pdf',file),'-dpdf');
mkdir(folderName);


for i=1:roiCount
    
    %coordinates per box
    j=roi(i,1:4);
    
    %crop image to box coordinates
    cropImage=imcrop(bin,j);
    
    %Transform cropped image into uint8 for imgaussfilt to work
    %cropImage=im2uint16(cropImage);
    
    %Apply blur
    %cropImage=imgaussfilt(cropImage,2);
   
    
    %cropImage=imresize(cropImage,[150 150],'box');
    %fileName=strcat('extract',int2str(i),'.png');
    n=99999;
    l=1;
    rand=randperm(n);
    out=rand(1);
    fileName=sprintf('extract-%d-%d.png',out,i);
    fullFileName=fullfile(folderName,fileName);
    imwrite(cropImage,char(fullFileName),'png');
    %export_fig(fullFileName);
    %print(cropImage,fullFileName,'-dpng');
end

%}

disp('----------------END----------------');
