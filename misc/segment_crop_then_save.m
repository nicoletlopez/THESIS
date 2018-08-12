clc;clear;close all

disp('----------------START----------------');
[file,path,indx]=uigetfile('*.png','Select Images','MultiSelect','on');
fileCount=numel(cellstr(file));

%disp(fileCount);
filePath=fullfile(path,file);

strFileCount=int2str(fileCount);
folderName=strcat('cropped-images-',strFileCount,string(file(1)),int2str(mod(fileCount,2)),string(file(fileCount)));
mkdir(folderName);
disp('Pre-processing and saving images...');
for i=1:fileCount
    
    filePath=cellstr(filePath);
    
    if isequal(fileCount,1)
        im=imread(filePath{1});
    else
        im=imread(filePath{i});
    end
    gray=rgb2gray(im);
    bin=imbinarize(gray);
    bw=imcomplement(bin);
    
    blobAnalyzer=vision.BlobAnalysis('MaximumCount',2);
    [area, centroids, roi] = step(blobAnalyzer, bw);
    im=imcrop(im,roi);
    n=99999;
    l=1;
    rand=randperm(n);
    out=rand(1);
    
    fileName=sprintf('cropped-image-%d-%d.png',out,i);
    fullFileName=fullfile(char(folderName),char(fileName));
    
    imwrite(im,fullFileName,'png');
    %export_fig(fullFileName,'png')
end
disp('----------------END----------------');