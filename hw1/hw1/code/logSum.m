# vector addition in logspace
function [ sumX ] = logSum( X )
    sumX = 0;
    N = length(X);

    # init to the first element
    sumX = X(1);

    # sum the rest of the elements
    for i = 2:N 
        x = X(i);

        pairMax = max(x, sumX);
        pairMin = min(x, sumX);
        
        # only the diff is exponentiated
        pairSum = pairMax + log(1.0 + exp(pairMin-pairMax));

        sumX = pairSum;
    endfor    
    
endfunction 

#feval('logSum', [0, 2, 5, 10.5])
