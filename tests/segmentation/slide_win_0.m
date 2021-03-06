clc; clear;

im=imread('binarized_check_no_edge.png');

% rgb to gray
% im2=rgb2gray(im);

% Loop through all the images to know if it's already in binary format
% (attempting to binarize a B&W image throws an error)
% Note: please turn into a helper function later
[rows,columns,numberOfColorChannels] = size(im);
if numberOfColorChannels > 1
    im2 = rgb2gray(im);
else
    im2 = im
end

% threshold
im_bw=im2<240;

% remove some clutter
im3=imopen(im_bw,ones(2,1));

[x,y]=find(im3);
im4=bwselect(im_bw,y,x,4);
im5 = imclose(im4,strel('disk',5));

im5 = bwmorph(im5,'thicken',2);


% bounding boxes
s=regionprops(im5,'PixelIdxList','Centroid','BoundingBox');
bboxes=cat(1,s.BoundingBox);
Iocr = insertShape(im, 'Rectangle', bboxes,'Color','blue');

figure; imshow(Iocr,[]);
hold all



% use OCR
for i=1:numel(s)    
   tmp=ceil(s(i).BoundingBox);
   tmp=im_bw(tmp(2):tmp(2)+tmp(4),tmp(1):tmp(1)+tmp(3),:);
   txt=ocr(tmp,'CharacterSet','0123456789');    
   text(s(i).Centroid(1),s(i).Centroid(2),txt.Text,'Color','r')    
end
