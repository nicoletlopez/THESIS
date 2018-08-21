classdef SVMClassifierClass < handle
    properties
        %input
        featureClassObject
        coding
        kernel
        %training outputs
        classifier
        trainingTime
        %testing outputs
        confusionMatrix
        accuracy
        precision
        recall
        FScore
        testingTime
    end
    methods
        function set.featureClassObject(obj,featureClassObject)
            obj.featureClassObject = featureClassObject;
        end
        function set.coding(obj,coding)
            obj.coding = coding;
        end
        function set.kernel(obj,kernel)
            obj.kernel = kernel;
        end
        
        function trainSVM(obj)
            pool = parpool;
            options = statset('UseParallel',true);
            
            tic;

            trainingFeatures = obj.featureClassObject.trainingFeatures;
            trainingLabels = obj.featureClassObject.imageSetClass.trainingLabels;
            
            disp('Setting SVM Template...');
            template = templateSVM('KernelFunction',obj.kernel,'SaveSupportVectors',true);
            disp('Training SVM...');
            obj.classifier = fitcecoc(trainingFeatures,trainingLabels,'Learners',template,...
                'Coding',obj.coding,'ObservationsIn','columns','Options',options);
            
            obj.trainingTime = toc;
            disp('Congratulations. Your SVM has been trained.');
            delete(gcp('nocreate'))

            load chirp
            sound(y,Fs)
        end
        
        function testSVM(obj)
            pool = parpool;
            options = statset('UseParallel',true);
            
            tic;
            
            testFeatures = obj.featureClassObject.testFeatures;
            testLabels = obj.featureClassObject.imageSetClass.testLabels;

            disp('Testing SVM...');
            predictedLabels = predict(obj.classifier,testFeatures,...
                'ObservationsIn','columns','Options',options);

            obj.confusionMatrix = confusionmat(testLabels,predictedLabels);
            obj.confusionMatrix = bsxfun(@rdivide, obj.confusionMatrix, sum(obj.confusionMatrix,2));
            %get accuracy
            obj.accuracy = mean(diag(obj.confusionMatrix));
            %get precision
            for i =1:size(obj.confusionMatrix,1)
                obj.precision(i)=obj.confusionMatrix(i,i)/sum(obj.confusionMatrix(:,i));
            end
            
            obj.precision=sum(obj.precision)/size(obj.confusionMatrix,1);
            %get recall
            for i =1:size(obj.confusionMatrix,1)
                obj.recall(i)=obj.confusionMatrix(i,i)/sum(obj.confusionMatrix(i,:));
            end

            obj.recall(isnan(obj.recall))=[];

            obj.recall=sum(obj.recall)/size(obj.confusionMatrix,1);
            %get f-score            
            obj.FScore=2*obj.recall*obj.precision/(obj.precision+obj.recall); %%F_score=2*1/((1/Precision)+(1/Recall));
            
            obj.testingTime = toc;
            delete(gcp('nocreate'))

            load chirp
            sound(y,Fs)
        end
    end
end

