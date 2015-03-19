function [ grad ] = LRgradient( X, y, w )
    
    [numSam, numFeat] = size(X);
    grad = zeros(numFeat,1);

    for f = 1:numFeat
        val = 0.0;
       
        for j = 1:numSam
            p = LRprob(X(j,:), w);
            val = val + (X(j,f)*(y(j) - p(2)));
        endfor    

        grad(f) = val;
    endfor    

end

#feval('LRgradient', [0.1, 0.2, 0.3; 0.3, 0.6, 0.4; 0.3, 0.1, 0.1], [1; 1; 0], [0.1; 0.4; 0.8])
