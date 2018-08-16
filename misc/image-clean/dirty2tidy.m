function dirty2tidy(filename)
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
    im16=im2uint16(im);
    if(isempty(map))
        if(size(im16,3)==1)
            bin=imbinarize(im16);
        else
            gray=rgb2gray(im16);
            bin=imbinarize(gray);
        end
    end
    bw=imcomplement(bin);
    blobAnalyzer=vision.BlobAnalysis('MaximumCount',10);
    [area, ~, roi] = step(blobAnalyzer, bw);
    areaConstraint=area<max(area);
    roi = double(roi(areaConstraint, :));
    im=insertShape(im16,'filledrectangle',roi,'color','white','opacity',1);
    im=rgb2gray(im);
    im=im2uint16(im);
    im = repmat(im,[1,1,3]);
    im=uint8(im);
    imwrite(im,filename)
end
%change back to calling directory, if necessary
if exist('currentdir','var')
    cd(currentdir)
end