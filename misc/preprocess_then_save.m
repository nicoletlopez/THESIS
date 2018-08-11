clc;clear;close all

disp('----------------START----------------');
[file,path,indx]=uigetfile('*.png','Select Images','MultiSelect','on');
fileCount=numel(cellstr(file));

%disp(fileCount);
filePath=fullfile(path,file);

strFileCount=int2str(fileCount);
folderName=strcat(strFileCount,string(file(1)),int2str(mod(fileCount,2)),string(file(fileCount)));
mkdir(folderName);
disp('Pre-processing and saving images...');
for i=1:fileCount
    filePath=cellstr(filePath);
    
    if isequal(fileCount,1)
        im=imread(filePath{1});
    else
        im=imread(filePath{i});
    end
    
    im=im(:,:,[1 1 1]);
    %uint16
    im=im2uint16(im);
    %im=imnoise(im,'speckle');
    im=rgb2gray(im);
    im=sauvola(im);
    %im=imcrop(im,size(im));
    
    fileName=sprintf('preprocessed-image%d.png',i);
    fullFileName=fullfile(char(folderName),char(fileName));
    
    imwrite(im,fullFileName,'png');
    %export_fig(fullFileName,'png')
end
disp('----------------END----------------');