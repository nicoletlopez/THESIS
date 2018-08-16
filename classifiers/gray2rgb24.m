function data = gray2rgb24(filename)
    im = imread(filename);
    im=im2uint16(im);
    im = repmat(im,[1,1,3]);
    im=uint8(im);
    data = im;
end