function data = resize_image(filename)
    image = imread(filename);
    data = imresize(image,[28 28]);
end