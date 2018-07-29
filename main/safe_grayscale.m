% This function sees if the image is already in grayscale format as running
% rgb2gray() on a grayscale image throws an error
function binarized_image = safe_grayscale(image)
    [~,~,numberOfColorChannels] = size(image);
    if numberOfColorChannels > 1
        binarized_image = rgb2gray(image);
    else 
        binarized_image = image;
    end
end

