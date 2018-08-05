clear;clc;close all;

im=imread('check.jpg');
gray=rgb2gray(im);

bin=sauvola(gray);

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
%{
Now, you'd call regionprops like this to find all of the bounding boxes in the image 
(after applying morphology):
%}


s=regionprops(im_close,'BoundingBox');
bb = round(reshape([s.BoundingBox], 4, []).');
%choose what picture u want to show, doesn't affect the results
img=insertShape(im2uint8(bin),'Rectangle',bb,'Color','blue');
imshow(img);
%{
for idx = 1 : numel(s)
    rectangle('Position', bb(idx,:), 'edgecolor', 'blue');
end
%}
