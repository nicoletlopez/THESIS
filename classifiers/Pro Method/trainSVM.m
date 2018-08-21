function [classifier,confusionMatrix] = trainSVM(featureClassObject,coding,kernel,getMetrics)
%TRAINSVM Train an SVM Classifier. Accepts a complete FeatureClass object

    pool = parpool;
    options = statset('UseParallel',true);

    trainingFeatures = featureClassObject.trainingFeatures;
    trainingLabels = featureClassObject.imageSetClass.trainingLabels;

    tic;
    template = templateSVM('KernelFunction',kernel,'SaveSupportVectors',true);
    classifier = fitcecoc(trainingFeatures,trainingLabels,'Learners',template,...
        'Coding',coding,'ObservationsIn','columns','Options',options);
    time = toc;
        if getMetrics == true
            testFeatures = featureClassObject.testFeatures;
            testLabels = featureClassObject.imageSetClass.testLabels;

            predictedLabels = predict(classifier,testFeatures,...
                'ObservationsIn','columns','Options',options);

            confusionMatrix = confusionmat(testLabels,predictedLabels);
            confusionMatrix = bsxfun(@rdivide, confusion_matrix, sum(confusionMatrix,2));
            %get accuracy
            accuracy = mean(diag(confusionMatrix))
            %get precision
            for i =1:size(confMat,1)
                precision(i)=confMat(i,i)/sum(confMat(:,i));
            end
            
            precision=sum(precision)/size(confMat,1);
            %get recall
            for i =1:size(confMat,1)
                recall(i)=confMat(i,i)/sum(confMat(i,:));
            end

            recall(isnan(recall))=[];

            recall=sum(recall)/size(confMat,1);
            %get f-score            
            F_score=2*recall*precision/(precision+recall); %%F_score=2*1/((1/Precision)+(1/Recall));
        else
            confusionMatrix = NaN;
        end

    delete(gcp('nocreate'))

    load chirp
    sound(y,Fs)
end

