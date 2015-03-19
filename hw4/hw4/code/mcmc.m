function [model] = mcmc(model, observed_variables, observed_values, iterations)
%MCMC Runs a number of iterations of Gibbs sampling on the
% given model, with specified observations.
%
% inputs:
%   model - A cell array of random variable structs,
%     potentially with uninitialized fields 'observed',
%     'value', and 'samples'.
%   observed_variables - A vector of IDs (indices)
%     indicating which random variables in 'model' are
%     observed.
%   observed_values - A vector containing the observed
%     values (parallel to 'observed_variables').
%   iterations - The number of iterations to run.
%
% outputs:
%   model - The modified cell array where each unknown
%     variable struct contains a list of T samples.

[unknown_variables, model] = init_mcmc( ...
    model, observed_variables, observed_values, iterations);

lu = length(unknown_variables);

for t = 1:iterations
    %t

    % ordering
    perm = randperm(lu);
    for o = 1:lu
        k = unknown_variables(perm(o));

        sample = sample_discrete(model, k);

        model{k}.value = sample;
        model{k}.samples(t) = sample;
    end
end

end

%model = load_diagnosis();

%feval('mcmc', model, [5], [1], 100000);

