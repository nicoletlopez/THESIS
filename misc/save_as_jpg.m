clc;clear;close all

[file,path,indx]=uigetfile('*.png','Select an image','MultiSelect','on');
fileCount=numel(file);
%disp(fileCount);

filePath=fullfile(path,file);

mkdir(fileCount);
for i=1:fileCount
    %disp(file(i));
    filePath(i);
    fileName=strcat('jpg-image',int2str(i),int2str(indx),'.jpg')
    
end
