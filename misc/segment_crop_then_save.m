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
    %buffersize = 4;
    %se = strel('disk',10);
    se = strel('line',11,90);
    bw=imcomplement(bin);
    bw=imclose(bw,se);
    
    blobAnalyzer=vision.BlobAnalysis('MaximumCount',10);
    [area, centroids, roi] = step(blobAnalyzer, bw);
    areaConstraint=area>20;

    %Keep regions that meet the area constraint
    roi = double(roi(areaConstraint, :));
    %{
    fig=insertShape(im, 'rectangle', roi,'Color','blue');
	figure('Name','Character segmentation without constraints'),
    imshow(fig);
    %}
    
    im=imcrop(gray,roi);   
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