function [ logl ] = LRlogLikelihood( X, y, w )
    [numSam, numFeat] = size(X);

    logl = 0.0;
    for j = 1:numSam
       p = LRprob(X(j,:), w);
       val = y(j)*log(p(2)) + (1-y(j))*log(p(1)); 
       logl = logl + val;
    endfor

end

#feval('LRlogLikelihood', [0.1, 0.5, 11; 0.3, 0.2, 14], [1; 0], [0.1; 0.2; 0.5])
