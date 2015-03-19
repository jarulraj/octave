function [ Ypred ] = predictWithStump( X, s )
%PREDICTWITHSTUMP 
    n = size(X,1);
    Ypred = zeros(n,1);

    %s

    for i=1:n
        if X(i,s.f) <= s.x
            Ypred(i) = s.o;
        else
            Ypred(i) = -s.o;
        end
    end

end

%s.f = 2;
%s.x = 0.5;
%s.o = 1;

%feval('predictWithStump', [1, 1; 1, 0; 1, 1; 1, 0; 0, 1; 0, 0; 0, 1; 0, 0], s) 
