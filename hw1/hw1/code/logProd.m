# vector multiplication in logspace
function [ xProd ] = logProd( X )
    # logProd is the sum of all the elements in X as 
    # they are already in logspace domain
    xProd = sum(X)
end

#feval('logProd', [0, 2, 5, 10.5])
