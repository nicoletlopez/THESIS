load fisheriris
X = meas;
Y = species;

% Construct the classifier using fitcknn
Mdl = fitcknn(X,Y);

Mdl.NumNeighbors = 4;

% Examine Quality of KNN Clasifier
rng(10);
Mdl = fitcknn(X,Y,'NumNeighbors',4);

% Classifier predicts incorrectly for rloss%
% of the data
rloss = resubLoss(Mdl)

% Construct a cros-validated model
CVMdl = crossval(Mdl);

% Examine the cross-validation loss, which is 
% the average loss of each cross-validation
% model when predicting on data that is 
% not used for training
kloss = kfoldLoss(CVMdl)