classdef FeatureClass < handle
    properties
        featureLayer
        net
        trainingFeatures
        testFeatures
        imageSetClass
    end
    methods
        function set.featureLayer(obj,featureLayer)
            obj.featureLayer = featureLayer
        end

        function set.net(obj,net)
            obj.net = net;
        end

        function set.imageSetClass(obj,imageSetClassObject)
            obj.imageSetClass = imageSetClassObject;
        end

        function generateTrainingFeatures(obj)
            disp('Generating TRAINING FEATURES...');
            trainingDatastore = obj.imageSetClass.trainingDatastore;
            inputSize = obj.net.Layers(1).InputSize;
            augmentedImages = augmentedImageDatastore(inputSize,trainingDatastore,...
                'ColorPreprocessing','gray2rgb');
            obj.trainingFeatures = activations(obj.net,augmentedImages,...
            obj.featureLayer,'MiniBatchSize',32,'OutputAs','columns',...
            'ExecutionEnvironment','gpu'); 
            disp('TRAINING FEATURES generated');
        end

        function generateTestFeatures(obj)
            disp('Generating TEST FEATURES...');
            testDatastore = obj.imageSetClass.testDatastore;
            inputSize = obj.net.Layers(1).InputSize;
            augmentedImages = augmentedImageDatastore(inputSize,testDatastore,...
                'ColorPreprocessing','gray2rgb');
            obj.testFeatures = activations(obj.net,augmentedImages,...
                obj.featureLayer,'ExecutionEnvironment','gpu');
            disp('TEST FEATURES generated');
        end
    end
end