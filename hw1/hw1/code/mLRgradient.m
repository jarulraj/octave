function [ grad ] = mLRgradient( X, y, W )
    
    [numSam, numFeat] = size(X);
    u = unique(y);
    numClass = length(u);
    grad = zeros(numClass,numFeat);
    p = zeros(numClass, numSam);
    
    for i = 1:numSam
        p(:,i) = mLRprob(X(i,:), W);
    endfor

    for c = 1:numClass
        for f = 1:numFeat
            val = 0.0;

            for i = 1:numSam
                c_ind = (y(i) == c);
                val =  val + (X(i,f) * (c_ind - p(c,i)));
            endfor

        grad(c,f) = val;
        endfor
    endfor

end
    
#feval('mLRgradient', [0.0, 0.6; 1.0, 0.4; 2.0, 0.5; 3.0, 0.1; 1.0, 0.5], [0, 1, 2, 3, 1], [0.7, 0.2; 0.9, 0.2; 0.7, 0.2; 0.8, 0.1])
