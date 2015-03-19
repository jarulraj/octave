function [ H ] = predictAdaBoost( X, alphas, stumps )
%PREDICTADABOOST 
    n = size(X,1);
    T = size(alphas,1);
    H = zeros(n, 1);

    for i=1:n
        val = 0;

        for j=1:T
            s = stumps{j};

            if X(i,s.f) <= s.x
                h_t = s.o;
            else
                h_t = -s.o;
            end

            val = val + alphas(j) * h_t;    
        end

        val

        if val <= 0
            pred = -1;
        else
            pred = +1;
        end

        H(i) = pred;
    end

end

%s1.f = 1;
%s1.x = 1.1;
%s1.o = -1;
%
%s2.f = 1;
%s2.x = 0.5;
%s2.o = -1;
%
%s3.f = 2;
%s3.x = 0.4;
%s3.o = 1;
%
%feval('predictAdaBoost',  [1, 1; 1, 0], 
%                           [ 2.1; 2.4; -1.5], 
%                          {s1; s2; s3})
