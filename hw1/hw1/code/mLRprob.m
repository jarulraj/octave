function [ p ] = mLRprob( x, W )
    
    numClass = size(W,1);
    p = zeros(numClass,1);

    xw_sum = 0.0;
    for c = 1:numClass
        xw = x * W(c,:)';
        xw_sum = xw_sum + exp(xw); 
    endfor

    for c = 1:numClass
        xw = x * W(c,:)';
        p(c) = exp(xw)/xw_sum;
    endfor

end

#feval('mLRprob', [0.1, -0.5], [0.1, -2.0; 0.8, -0.8; 0.5, 0.3])
