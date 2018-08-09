% This script should be run ONLY if you do not yet have an image datastore
% in the workspace memory. Otherwise, skip this part

rootFolder = fullfile(pwd,'english');
categories = {'0' '1' '2' '3' '4' '5' '6' '7' '8' '9' 'a' 'A' 'b' 'B' 'c' 'C' ...
    'd' 'D' 'e' 'E' 'f' 'F' 'g' 'G' 'h' 'H' 'i' 'I' 'j' 'J' 'k' 'K' 'l' 'L' ...
    'm' 'M' 'n' 'N' 'o' 'O' 'p' 'P' 'q' 'Q' 'r' 'R' 's' 'S' 't' 'T' 'u' 'U' ...
    'v' 'V' 'w' 'W' 'x' 'X' 'y' 'Y' 'z' 'Z'};

imds = imageDatastore(fullfile(rootFolder,categories), 'LabelSource','foldernames');

% split the datastore into training and testing
[trainingSet, testSet] = splitEachLabel(imds,0.3,'randomize');

testLabels = testSet.Labels;