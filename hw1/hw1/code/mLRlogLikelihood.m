function [ logl ] = mLRlogLikelihood( X, y, W )
    
    [numSam, numFeat] = size(X);
    u = unique(y);
    numClass = length(u);

    logl = 0.0;
    for i = 1:numSam
        for j = 1:numClass
            if y(i) == j
                xw_sum = 0.0;
                for c = 1:numClass
                    xw = X(i,:) * W(c,:)';
                    xw_sum = xw_sum + exp(xw); 
                endfor
                 
                xw = X(i,:) * W(j,:)';
                val = log(exp(xw)/xw_sum); 

                logl = logl + val;
            endif
        endfor
    endfor

end

#feval('mLRlogLikelihood', [0.0, 0.6; 1.0, 0.4; 2.0, 0.5; 3.0, 0.1; 1.0, 0.5], [0, 1, 2, 3, 1], [0.5, 5.2; 0.7, 0.2; 0.6, 0.2; 0.5, 0.1])
