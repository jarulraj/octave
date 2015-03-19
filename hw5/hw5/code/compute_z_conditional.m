function [z_d] = compute_z_conditional(words, phi, theta, d)
%COMPUTE_Z_CONDITIONAL Computes the conditional
% distribution of the variable z_d given w, phi, and theta,
% for document d.
%
% inputs:
%   words - A cell array of length D, where each element is
%     a [1 x N_d] vector of words (N_d is the number of
%     words in document d). See 'make_data'.
%   phi - A matrix of dimension [K x W] where phi(k,:) is
%     the current "guess" of the value of phi_k, as provided
%     by the M step.
%   theta - A matrix of dimension [D x K] where theta(d,:)
%     is the current "guess" of the value of theta_d, as
%     provided by the M step.
%
% output:
%   z_d - An [K x N_d] matrix where z_d(:,i) is a vector
%     containing the conditional probability distribution
%     p(z_{di} | w, phi, theta).

D = length(words);		% number of documents
K = size(phi, 1);		% number of topics
N_d = length(words{d}); % number of words in document d

% TODO: implement me!
z_d = zeros(K, N_d);

for j = 1:K 
    for i = 1:N_d
        z_d(j,i) = phi(j, words{d}(i)) * theta(d, j);
    end
end

for i = 1:N_d
    z_d(:,i) = z_d(:,i) / sum(z_d(:,i));                                                                                                   
end    

end

%[words, word_map, inverse_word_map] = make_data();
%
%words
%word_map
%inverse_word_map
%
%D = length(words);
%W = size(inverse_word_map,2);
%K = 2;
%
%% initialize phi and theta (don't change this!)
%phi = rand(K, W);
%theta = rand(D, K);
%
%for k = 1:K 
%    phi(k,:) = phi(k,:) / sum(phi(k,:));                                                                                                   
%end
%
%for d = 1:D 
%    theta(d,:) = theta(d,:) / sum(theta(d,:));
%end
%
%D
%W
%K
%phi
%theta
%
%d = 2
%feval('compute_z_conditional', words, phi, theta, d);                                             
%
