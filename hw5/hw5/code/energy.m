function [q] = energy(words, z, phi, theta, alpha, pi)
%ENERGY Computes the expectation of the log posterior
% probability with respect to the conditional distribution
% of z given all other variables:
% E[log p(phi, theta, z | w)] where the expectation is
% taken over p(z | w, phi, theta) and constant terms are
% omitted.
%
% inputs:
%   words - A cell array of length D, where each element is
%     a [1 x N_d] vector of words (N_d is the number of
%     words in document d). See 'make_data'.
%   z - A cell array of length D, where each element is a
%     [K x N_d] matrix. Each column of this matrix z_d(:,i)
%     is a vector containing the conditional probability
%     distribution p(z_{di} | w, phi, theta), as returned
%     by 'compute_z_conditional'.
%   phi - A matrix of dimension [K x W] where phi(k,:) is
%     the current "guess" of the value of phi_k, as provided
%     by the M step.
%   theta - A matrix of dimension [D x K] where theta(d,:)
%     is the current "guess" of the value of theta_d, as
%     provided by the M step.
%   alpha - A [1 x K] vector containing the Dirichlet prior
%     parameter for theta_d (see handout).
%   pi - A [1 x W] vector containing the Dirichlet prior
%     parameter for phi_k (see handout).
%
% output:
%   probability - A scalar with the expectation of the log
%     posterior probability: E[log p(phi, theta, z | w)],
%     where the expectation is taken over
%     p(z | w, phi, theta) and constant terms are omitted.

D = length(words);		% number of documents
K = size(phi, 1);		% number of topics
W = size(phi, 2);       % number of words

% TODO: implement me!
q = 0;

% first term
p_w = 0;
for d=1:D
    N_d = length(words{d});
    for i=1:N_d
        for j = 1:K
            p_w = p_w + z{d}(j,i) * log( phi(j, words{d}(i)) ); 
        end
    end
end

% second term
p_z = 0;
for d=1:D
    N_d = length(words{d});
    for i=1:N_d
        for j = 1:K
            p_z = p_z + z{d}(j,i) * log( theta(d,j) ); 
        end
    end
end


% third term
p_theta = 0;
for d =1:D
    for j = 1:K
        p_theta = p_theta + (alpha(j) - 1) * log ( theta(d,j) );
    end
end
 
% fourth term
p_phi = 0;
for j = 1:K
    for i =1:W
        p_phi = p_phi + (pi(i) - 1) * log ( phi(j,i) );
    end
end

p_w
p_z
p_theta
p_phi

q = p_w + p_z + p_theta + p_phi;
q

end
 
%[words, word_map, inverse_word_map] = make_data();
%
%%words
%%word_map
%%inverse_word_map
%
%D = length(words);
%W = size(inverse_word_map,2);
%K = 2;
%
%% uniform prior
%pi = ones(W)*2.0;
%alpha = ones(K)*2.0; 
%
%phi = rand(K, W);
%theta = rand(D, K);
%
%% phi
%for k = 1:K 
%    for i = 1:W
%        phi(k,i) = randg(pi(i));
%    end
%end
%for k = 1:K 
%    phi(k,:) = phi(k,:) / sum(phi(k,:));                                                                                                   
%end
%
%% theta
%for d = 1:D 
%    for k = 1:K
%        theta(d,k) = randg(alpha(k));
%    end
%end
%for d = 1:D 
%    theta(d,:) = theta(d,:) / sum(theta(d,:));
%end
%
%phi
%theta
%
%
%% z
%z = {};
%for d = 1:D 
%    z{d} = compute_z_conditional(words, phi, theta, d);
%end
%z
%
%feval('energy', words, z, phi, theta, alpha, pi);                                             
%  
