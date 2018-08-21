clc;

categories = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'A', 'b', 'B', 'C', ...
    'd', 'D', 'e', 'E', 'f', 'F', 'g', 'G', 'h', 'H', 'I', 'J', 'K', 'L', ...
    'M', 'n', 'N', 'O', 'P', 'q', 'Q', 'r', 'R', 'S', 't', 'T', 'U', ...
    'V', 'W', 'X', 'Y', 'Z'};


disp('START...');
for ctr = 1:numel(categories)
    %change this
    directory_string = '/home/pam/Documents/FINAL/extracted_extended_tidied/';
    directory_string = string(strcat(directory_string,categories(ctr)));
    dirty2tidy(directory_string);
    disp([num2str(ctr), ' - ', categories(ctr)])
end
disp('END...');

