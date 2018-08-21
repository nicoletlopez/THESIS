load fisheriris
X = meas;    
Y = species; 
Mdl = fitcknn(X,Y,'NumNeighbors',4);

flwr = mean(X);
flwrClass=  predict(Mdl,flwr)