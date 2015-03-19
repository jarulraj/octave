function [theta_d] = maximize_theta(words, z, alpha, d)
%MAXIMIZE_THETA Compute the arg max of the energy function
% q with respect to theta_d.
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
%   alpha - A [1 x K] vector containing the Dirichlet prior
%     parameter for theta_d (see handout).
%   d - A scalar indicating the document d for which to
%     compute the optimal theta_d.
%
% outputs:
%   theta_d - A [1 x K] vector containing the value of
%     theta_d that maximizes the energy function q.

K = length(alpha);		% number of topics
N_d = length(words{d});	% number of words in document d

% TODO: implement me!
theta_d = zeros(1, K);
 
for j=1:K

    % first term
    p_z = 0;
    for i=1:N_d
        p_z = p_z + z{d}(j,i); 
    end

    % second term
    p_theta = alpha(j)-1; 

    %p_z
    %p_theta
    theta_d(j) = p_z + p_theta;

end

norm_c = sum(theta_d);
for j = 1:K
    theta_d(j) = theta_d(j) / norm_c;                                                                                                   
end

%theta_d

end


%[words, word_map, inverse_word_map] = make_data();
%
%words
%word_map
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
%z = {};
%for d = 1:D 
%    z{d} = compute_z_conditional(words, phi, theta, d);
%end
%z
%
%d = 2
%feval('maximize_theta', words, z, alpha, d);                                             
%
