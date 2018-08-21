root_folder = fullfile('/home','pam','Documents','FINAL',...
    'hsf_dataset_resized_1400_cropped');
    categories = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'A', 'b', 'B', 'C', ...
    'd', 'D', 'e', 'E', 'f', 'F', 'g', 'G', 'h', 'H', 'I', 'J', 'K', 'L', ...
    'M', 'n', 'N', 'O', 'P', 'q', 'Q', 'r', 'R', 'S', 't', 'T', 'U', ...
    'V', 'W', 'X', 'Y', 'Z'};

imds = imageDatastore(fullfile(root_folder,categories),'LabelSource','foldernames');


% Limit total data count (e.g. only 100 per class)
% minSetCount = 100;
% imds = splitEachLabel(imds,minSetCount);

% View the number of samples per category
tbl = countEachLabel(imds)

% Split the data into testing and training data 
[training_set, test_set] = splitEachLabel(imds,0.3);

% Labels are what a single image is defined as 
training_set_labels = training_set.Labels;
test_set_labels = test_set.Labels; 