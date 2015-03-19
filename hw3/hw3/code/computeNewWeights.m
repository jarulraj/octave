function [ Dnew ] = computeNewWeights( X, Y, D, alpha, s)
%COMPUTENEWWEIGHTS 
    n = size(D);
    Dnew = zeros(n);

    for i=1:n
        if X(i,s.f) <= s.x
            pred = s.o;
        else
            pred = -s.o;
        end

        Dnew(i) = D(i) * exp(-alpha * Y(i) * pred); 
    end
    
    Dnew_normed = Dnew / norm(Dnew, 1);
    Dnew = Dnew_normed;
end

%s.f = 2;
%s.x = 1.1;
%s.o = -1;

%feval('computeNewWeights', [1, 1; 1, 0; 1, 1.2; 1, 0; 1, 1; 1, 0; 1, 1; 1, 0], 
%                           [ 1; 1; 1; 1; 1; -1; -1; -1], 
%                           [0.125; 0.125; 0.125; 0.125; 0.125; 0.125; 0.125; 0.125], -0.24, s)
