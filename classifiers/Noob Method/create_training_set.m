root_folder = fullfile('C:\','Users','Jade_Ericson','Documents','MATLAB','Training','training_set');
    categories = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'A', 'b', 'B', 'C', ...
    'd', 'D', 'e', 'E', 'f', 'F', 'g', 'G', 'h', 'H', 'I', 'J', 'K', 'L', ...
    'M', 'n', 'N', 'O', 'P', 'q', 'Q', 'r', 'R', 'S', 't', 'T', 'U', ...
    'V', 'W', 'X', 'Y', 'Z'};

training_set = imageDatastore(fullfile(root_folder,categories),'LabelSource','foldernames');
training_set_labels = training_set.Labels;
% View the number of samples per category
tbl = countEachLabel(training_set)