function [ cls ] = mLRclassify( XTrain, yTrain, XTest )
    #filename = '../../data/XTrainIris.mat';
    #load(filename)
    #filename = '../../data/yTrainIris.mat';
    #load(filename)
    #filename = '../../data/XTestIris.mat';
    #load(filename)
 
    [numSam, numFeat] = size(XTrain);
    [numTest, numFeat] = size(XTest);
    u = unique(yTrain);
    numClass = length(u);

    % Train the model
    fgrad = @(W) mLRgradient( XTrain, yTrain, W ); 
    flogl = @(W) mLRlogLikelihood( XTrain, yTrain, W ); 

    W0 = zeros(numClass, numFeat); 
    step = 0.05;
    niter = 1000;

    W = gradDescent(flogl, fgrad, W0, step, niter);

    % Use the model to classify 
    cls = zeros(numTest,1);
         
    for t = 1:numTest  
        classProbs = mLRprob(XTest(t,:), W);
        [classProb classInd] = max(classProbs);
        label = u(classInd);
        cls(t) = label;
    endfor

end

#feval('mLRclassify', [0.0, 0.6; 0.5, 0.3; 0.5, 0.5; 0.8, 0.6; 0.8, 0.8], [0; 0; 1; 1; 2], [0.5, 0.3; 0.8, 0.7])

