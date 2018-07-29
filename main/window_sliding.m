% Segment an image subjected to Sauvola
% function segmented_image = window_sliding(binarized_image)
function window_sliding(binarized_image)
    % Binarize again?!
    im2 = safe_grayscale(binarized_image)
    
    % Threshold 
    im_bw = binarized_image<240;
    
    % Remove some clutter
    im3 = imopen(im_bw,ones(2,1));
    
    [x,y] = find(im3);
    im4 = bwselect(im_bw,y,x,4);
    im5 = imclose(im4,strel('disk',5));
    
    im5 = bwmorph(im5,'thicken',2);
    
    % Bounding boxes (strictly for demonstration use)
    % Remove if not necessary
    s = regionprops(im5,'PixelIdxList','Centroid','BoundingBox');
    bboxes = cat(1,s.BoundingBox);
    Iocr = insertShape(binarized_image, 'Rectangle',bboxes,'Color','blue');
    
    figure;
    imshow(Iocr,[]);
    hold all
end