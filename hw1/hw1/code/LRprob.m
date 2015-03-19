function [ p ] = LRprob(x, w )
    xw = x * w;

    p0 = 1.0 ./ (1.0+exp(xw));
    p1 = 1.0 - p0;

    p = [p0; p1];    
end

#feval('LRprob', [0.1, 0.5, 0.2], [0.1; 0.2; 0.5])

