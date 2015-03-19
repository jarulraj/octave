function [probability] = conditional_given_all(model, var_id)
%CONDITIONAL_GIVEN_ALL Computes the conditional
% distribution of the variable var_id given all other
% variables.
%
% inputs:
%   model - A cell array of random variable structs.
%   var_id - The ID of the variable for which to compute
%     the conditional distribution.
%
% output:
%   probability - A [1 x k] vector where k = length(
%     model{var_id}.values)). The element at i should be
%     the conditional probability that the variable var_id
%     is equal to the ith outcome, given that the value of
%     every other variable j in the model is
%     'model{j}.value'.

probability = ones(1, length(model{var_id}.values));

for i = 1:length(model{var_id}.values)
    v = model{var_id}.values(i);
    model{var_id}.value = v;

    parent_prob = conditional_given_parents(model, var_id);
    p_init = parent_prob(i);

    c_prod = 1;
    for j = 1:length(model{var_id}.children)
        child_id = model{var_id}.children(j);
        child_prob = conditional_given_parents(model, child_id);
        
        child_value = model{child_id}.value;
        c_prod = c_prod * child_prob(child_value+1);
    end

    probability(i) = p_init * c_prod;
end

% Normalize
probability = probability / sum(probability);

end

%model = load_diagnosis();
%model{1}.value = 0; 
%model{2}.value = 0; 
%model{3}.value = 0; 
%model{5}.value = 0; 
%
%feval('conditional_given_all', model, 4);
