function im2bit1(filename)
%Get image names
if isstruct(filename) %assuming it is a struct as produced from DIR
    files=filename;
elseif isdir(filename) %if the input is a directory, get all the image files from the directory
    currentdir=pwd;
    cd (filename)
    files=[dir('*.png'); dir('*.gif'); dir('*.bmp'); dir('*.jpg')];
else %if it is a single file:
    files.name=filename;
end
%loop over all the files
for n=1:length(files)
    filename=files(n).name;
    [im,map]=imread(filename);
    im=im2uint16(im);
    if(isempty(map))
        if(size(im,3)==1)
            im=imbinarize(im);
        else
            im=rgb2gray(im);
            im=imbinarize(im);
        end
    end
    imwrite(im,filename)
end
%change back to calling directory, if necessary
if exist('currentdir','var')
    cd(currentdir)
end