function [s, eps] = chooseBestStump( X, Y, D, fs, xs, gains)
%CHOOSEBESTSTUMP Return the stump with the highest info gain. 
% Output: 
%   s - a struct with three fields: f, x, o. 
%       s.f - the feature along which you split
%       s.x - the value around which you split <= x, > x
%       s.o - the orientation of the stump = the label the stump assigns 
%               to the points <=x
%   eps - the weighted error of the stump s. 
%
% NOTE: The information gain only pins down f and x. The orientation 
% is given by whichever orientation leads to a lower stump error. 
% e.g. a stump separating -+ will have s.o = -1, and a stump separating 
% +- will have s.o = +1; In case of tie, take s.o = -1. 

    n = size(X,1);
    ns = size(gains,1);

    s.f = 0;
    s.x = 0;
    s.o = 0;
    eps = 0;
    
    [max_val,max_idx] = max(gains);

    s.f = fs(max_idx);
    s.x = xs(max_idx);

    s.o = -1;
    for i=1:n
        if X(i,s.f) <= s.x
            pred = s.o;
        else
            pred = -s.o;
        end

        if pred != Y(i)
            eps = eps + D(i);
        end
    end

    %eps

    if eps > 0.5
        s.o = +1;
        eps = 1-eps;
    end

    %eps
end

%feval('chooseBestStump', [1, 1; 1, 0; 1, 1; 1, 0; 0, 1; 0, 0; 0, 1; 0, 0], 
%                         [ 1; 1; 1; 1; 1; -1; -1; -1], 
%                         [0.125; 0.125; 0.0; 0.0; 0.125; 0.375; 0.125; 0.0],
%                         [1; 2], [0.5; 0.5], [0.549; 0.049])
