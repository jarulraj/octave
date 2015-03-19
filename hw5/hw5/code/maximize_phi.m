function [phi_k] = maximize_phi(words, z, pi, k)
%MAXIMIZE_PHI Compute the arg max of the energy function
% q with respect to phi_k.
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
%   pi - A [1 x W] vector containing the Dirichlet prior
%     parameter for phi_k (see handout).
%   k - A scalar indicating the topic k for which to
%     compute the optimal phi_k.
%
% outputs:
%   phi_k - A [1 x W] vector containing the value of phi_k
%     that maximizes the energy function q.

D = length(words); % number of documents
W = length(pi);    % size of dictionary

% TODO: implement me!
phi_k = zeros(1, W);

for i=1:W

    % first term                                                              
    p_w = 0;                                                                  
    for d=1:D               
        N_d = length(words{d});

        for m=1:N_d
            if words{d}(m) == i
                p_w = p_w + z{d}(k,m);
            end
        end
    end                                                                       

    % second term                                                             
    p_phi = pi(i)-1;                                                     
    
    phi_k(i) = p_w + p_phi;                                               
end                                                                           

norm_c = sum(phi_k);                                                         
for i = 1:W                                                                   
    phi_k(i) = phi_k(i) / norm_c;                                                
end                                                                           

%phi_k                                                                       

end                                                                           

%[words, word_map, inverse_word_map] = make_data();                           
%
%words                                                                        
%%word_map                                                                     
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
%         phi(k,i) = randg(pi(i));                                             
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
%%phi                                                                          
%%theta                                                                        
%
%z = {};                                                                      
%for d = 1:D                                                                  
%    z{d} = compute_z_conditional(words, phi, theta, d);                      
%end                                                                          
%z                                                                            
%
%k = 2                                                                        
%feval('maximize_phi', words, z, pi, k);                                 
%
