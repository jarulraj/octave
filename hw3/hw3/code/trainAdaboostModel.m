function [ alphas, stumps ] = trainAdaboostModel( X, Y, Tmax )
%TRAINADABOOSTMODEL 
% Train an Adaboost model with decision stumps. 
%
% Train the model for a number of iterations t. At each iteration i learn 
% a weak learner (stumps{i}) and weight (alphas(i)). For each such weak 
% learner compute its weighted training error eps_t. Stop training if 
% eps_t = 0.5 (for robustness: if eps_i very close to 0.5!), or if the
% maximum number of iterations Tmax was achieved. 
%
% Output: alphas, stumps - arrays of size t where t 
%   is the # of iterations completed before stopping. 

    alphas = zeros(Tmax,1);
    stumps = cell(Tmax,1);
    n = size(X,1);
    D = (1/n) * ones(n,1);
    
    eps_t = 0.5;
    gap = 1e-10;

    for t=1:Tmax
        [ns, fs, xs, gains] = getWeightedInfoGainForStumps(X, Y, D);
        [s, eps] = chooseBestStump(X, Y, D, fs, xs, gains);
        eps

        [alpha] = computeAlpha(eps);
        alpha

        [Dnew] = computeNewWeights(X, Y, D, alpha, s);
        D = Dnew;

        alphas(t) = alpha;
        stumps{t} = s;

        if abs(eps-eps_t) < gap
            break;
        end
    end

    t_i = t-1;
    alphas = alphas(1:t_i);
    stumps = stumps(1:t_i);

    alphas
    %stumps
end                    

%feval('trainAdaboostModel', [1.1, 1; 1.6, 0; 1, 1.2; 1, 0; 1, 1; 0.2, 0; 1, 0.3; 1, 0], 
%                            [ 1; 1; -1; 1; 1; -1; 1; -1], 10); 
                

