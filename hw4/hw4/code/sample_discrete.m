function [sample] = sample_discrete(model, var_id)
%SAMPLE_DISCRETE Samples from the conditional distribution
% of the variable var_id, given that the value of every
% other variable j in the model is 'model{j}.value'.

sample = 0;
prob = conditional_given_all(model, var_id);
sample = discrete_rnd(model{var_id}.values, prob, 1); 

end
 
%model = load_diagnosis();
%model{1}.value = 1; 
%model{2}.value = 0; 
%model{3}.value = 1; 
%model{5}.value = 0; 
%
%feval('sample_discrete', model, 4); 
