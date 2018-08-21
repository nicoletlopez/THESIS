classdef FeatureClass < handle
    properties
        featureLayer
        net
        trainingFeatures
        trainingFeaturesExtractionTime
        testFeatures
        testFeaturesExtractionTime
        imageSetClass
    end
    methods
        function set.featureLayer(obj,featureLayer)
            obj.featureLayer = featureLayer;
        end

        function set.net(obj,net)
            obj.net = net;
        end

        function set.imageSetClass(obj,imageSetClassObject)
            obj.imageSetClass = imageSetClassObject;
        end

        function generateTrainingFeatures(obj)
            disp('Generating TRAINING FEATURES...');
            tic;
            disp('Creating Training Image Data Store...');
            trainingDatastore = obj.imageSetClass.trainingDatastore;
            disp('Getting Training Image Data Store Size...');
            inputSize = obj.net.Layers(1).InputSize;
            disp('Augmenting Training Image Data Store...');
            augmentedImages = augmentedImageDatastore(inputSize,trainingDatastore,...
                'ColorPreprocessing','gray2rgb');
            disp('Extracting Training Features...');
            obj.trainingFeatures = activations(obj.net,augmentedImages,...
                obj.featureLayer,'MiniBatchSize',32,'OutputAs','columns',...
                'ExecutionEnvironment','gpu');
            obj.trainingFeaturesExtractionTime = toc;
            disp('TRAINING FEATURES generated');

            load chirp
            sound(y,Fs)
        end

        function generateTestFeatures(obj)
            disp('Generating TEST FEATURES...');
            tic;
            disp('Creating Testing Image Data Store...');
            testDatastore = obj.imageSetClass.testDatastore;
            disp('Getting Testing Image Data Store Size...');
            inputSize = obj.net.Layers(1).InputSize;
            disp('Augmenting Testing Image Data Store...');
            augmentedImages = augmentedImageDatastore(inputSize,testDatastore,...
                'ColorPreprocessing','gray2rgb');
            disp('Extracting Testing Features...');
            obj.testFeatures = activations(obj.net,augmentedImages,...
                obj.featureLayer,'MiniBatchSize',32,'OutputAs','columns',...
                'ExecutionEnvironment','gpu');
            disp('TEST FEATURES generated');
            obj.testFeaturesExtractionTime = toc;

            load chirp
            sound(y,Fs)
        end
    end
end