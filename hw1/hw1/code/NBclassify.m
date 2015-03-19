function [ classPred ] = NBclassify( XTrain, XTest, yTrain )
    #filename = '../../data/XTrainWBC.mat';
    #load(filename)
    #filename = '../../data/yTrainWBC.mat';
    #load(filename)
    #filename = '../../data/XTestWBC.mat';
    #load(filename)

    [numSam, numFeat] = size(XTrain);
    u = unique(yTrain);
    numClass = length(u);
    numTest = size(XTest,1);
    classPred = zeros(numTest, 1);
    
    mu = zeros(numClass,numFeat);
    sigma = zeros(numClass,numFeat);
    prior = zeros(numClass, 1);

    prior = NBprior(yTrain);
    [mu, sigma] = NBparameters(XTrain, yTrain);
    sigma = sigma + eps(numClass, numFeat);

    for t = 1:numTest
        labelEst = zeros(numClass,1);

        for c = 1:numClass
            val = prior(c);
            for f = 1:numFeat
                featEst = (1.0 / ((2 * pi * sigma(c,f)).^ 0.5)) * exp(-((XTest(t,f)-mu(c,f))^2.0)/(2.0* sigma(c,f))); 
                val = val * featEst;
            endfor
            labelEst(c) = val;
        endfor

        % assign label with max prob
        [labelProb labelInd] = max(labelEst);
        label = u(labelInd);
        classPred(t) = label;
    endfor

end

#feval('NBclassify', [1, 13, 1 ; 1, 12, 1; 5, 2, 13; 6, 1, 12; 1, 2, -18; 2, -1, -15], [1, 5, -11 ; 5, 5, 12; 1, 15, -18], [1, 1, 5, 5, 8, 8]) 


