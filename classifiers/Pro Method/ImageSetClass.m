classdef ImageSetClass < handle
    properties
        trainingDatastore
        testDatastore
        trainingLabels
        testLabels
    end
    properties(Constant)
        CATEGORIES = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'A', 'b', 'B', 'C', ...
                'd', 'D', 'e', 'E', 'f', 'F', 'g', 'G', 'h', 'H', 'I', 'J', 'K', 'L', ...
                'M', 'n', 'N', 'O', 'P', 'q', 'Q', 'r', 'R', 'S', 't', 'T', 'U', ...
                'V', 'W', 'X', 'Y', 'Z'};
    end
    methods
        function set.trainingDatastore(obj,directoryPath)
            obj.trainingDatastore = imageDatastore(fullfile(directoryPath,obj.CATEGORIES),...
                'LabelSource','foldernames');
            obj.trainingLabels = obj.trainingDatastore.Labels;
        end
        
        function set.testDatastore(obj,directoryPath)
            obj.testDatastore = imageDatastore(fullfile(directoryPath,obj.CATEGORIES),...
                'LabelSource','foldernames','ReadFcn',@gray2rgb24);
            obj.testLabels = obj.testDatastore.Labels;
        end
    end
end