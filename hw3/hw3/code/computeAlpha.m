function [ alpha ] = computeAlpha( eps )
%COMPUTEALPHA 
    alpha = 0;

    if eps>0 && eps<1
        alpha = 0.5 * log((1-eps)/eps);
    end
end

%feval('computeAlpha', 0.500) 
