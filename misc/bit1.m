clc;
categories = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'A', 'b', 'B', 'C', ...
    'd', 'D', 'e', 'E', 'f', 'F', 'g', 'G', 'h', 'H', 'I', 'J', 'K', 'L', ...
    'M', 'n', 'N', 'O', 'P', 'q', 'Q', 'r', 'R', 'S', 't', 'T', 'U', ...
    'V', 'W', 'X', 'Y', 'Z'};


disp('START...');
for ctr = 1:numel(categories)
    %change this
    directory_string = '/home/nicole/Documents/FINAL/0/';
    directory_string = string(strcat(directory_string,categories(ctr)));
    im2bit1(directory_string);
    disp([num2str(ctr), ' - ', categories(ctr)])
end
disp('END...');