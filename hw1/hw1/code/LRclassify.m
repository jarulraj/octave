function [ cls ] = LRclassify( XTrain, yTrain, XTest )
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

    % Train the model
    fgrad = @(w) LRgradient( XTrain, yTrain, w );
    flogl = @(w) LRlogLikelihood( XTrain, yTrain, w );
    
    w0 = zeros(numFeat,1);
    step = 0.05;
    niter = 1000;
    
    [w] = gradDescent(flogl, fgrad, w0, step, niter);

    % Use the model to classify 
    [numTest, numFeat] = size(XTest);
    cls = zeros(numTest,1);

    for t = 1:numTest  
        xw = XTest(t,:) * w;
        p0 = 1.0 ./ (1.0+exp(xw));
        cls(t) = 1 - (p0 > 0.5);
    endfor

end

#feval('LRclassify', [0.1, 0.5, 11; 0.3, 0.2, 1.4; 0.3, 0.2, 1.3], [1; 0; 0], [0.1, 0.2, 12; 0.3, 0.2, 1.7])
