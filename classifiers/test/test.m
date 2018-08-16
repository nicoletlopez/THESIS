clc;
ex = imread('extract-1130-601.png');
size(ex)

nist = imread('hsf_0_00000.png');
size(nist)

nist = augmentedImageDatastore(