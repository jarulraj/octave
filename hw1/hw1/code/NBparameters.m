function [ mu, sigma ] = NBparameters( XTrain, yTrain )
    [numSam, numFeat] = size(XTrain);
    u = unique(yTrain);
    numClass = length(u);

    mu = zeros(numClass,numFeat);
    count = zeros(numClass, 1);
    sigma = zeros(numClass,numFeat);

    for c = 1:numClass
        for i = 1:numSam
            if yTrain(i) == u(c)
                count(c) = count(c) + 1;
                for f = 1:numFeat
                    mu(c,f) = mu(c,f) + XTrain(i,f); 
                endfor
            endif
        endfor
    endfor

    for c = 1:numClass
        for f = 1:numFeat
            mu(c,f) = mu(c,f) / count(c); 
        endfor
    endfor
 
    for c = 1:numClass
        for i = 1:numSam
            if yTrain(i) == u(c)
                for f = 1:numFeat
                    sigma(c,f) = sigma(c,f) + (XTrain(i,f) - mu(c,f))^2.0 ; 
                endfor
            endif
        endfor
    endfor
 
    for c = 1:numClass
        for f = 1:numFeat
            sigma(c,f) = sigma(c,f) / count(c); 
        endfor
    endfor

    #printf("mu: \n");
    #disp(mu);
    #printf("sigma: \n");
    #disp(sigma);
end

#feval('NBparameters', [1, 0, 3 ; 2, 0, 5; 2, 2, 6], [1, 5, 5])
