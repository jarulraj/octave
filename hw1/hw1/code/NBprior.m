function [ probs ] = NBprior( yTrain )
    u = unique(yTrain);
    numClass = length(u);
    numSam = length(yTrain);
    probs = zeros(numClass,1);

    for i = 1:numClass
        probs(i) = sum(yTrain == u(i))/numSam;
    endfor    

end


#feval('NBprior', [0, 1])

