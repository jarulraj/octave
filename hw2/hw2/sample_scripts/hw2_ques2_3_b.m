% Homework 2, Question 2, 3.b
%
% Fill in the missing code below!

clear all;

p_H_star = 0.6; % the value of the true parameter
sigma_squared = [];  % the variance, you'll need to define this (i/N_bits)
sigma = [];  % the s.d, you'll need to define this
p_H = 0:0.01:1;  % sample p_H
N_bits = [100 500 1000 2500]; % trial size varies
L = [];  % L: num_trial_sizes x num_ph_samples, each row corresponds to the
         % likelihood of one trial size vs. p_H plot
max_L = [];  % max_L: num_trial_sizes x 1, keeps track of the maximum likelihood 
max_L_inds = []; % num_trial_sizes x 1, keeps track of index in p_H with max likelihood
colors = {[0 0 1], [0 1 0], [1 0 0], [0 0 0]}; % colors for the lines

%rng(10701); % sets the random seed to produce identical output each time
         

%% FILL IN THE MISSING CODE HERE
%
%  --- ALTER THIS CODE ---

sqrt2pi = sqrt(2*pi);

for iseq = 1:length(N_bits)
    N_bit = N_bits(iseq);

    for bseq = 1:N_bit
        sigma_squared(bseq) = bseq/N_bit;
        sigma(bseq) = sqrt(sigma_squared(bseq));
    end
    
    O = binornd(1,p_H_star,1,N_bit) + normrnd(0,sigma_squared,1,N_bit);

    for pseq = 0:1:100
        p = pseq/100;

        logl = 0;
        for bseq = 1:N_bit
            n_0 = exp(-((O(bseq))^2)/(2*sigma_squared(bseq)))/(sigma(bseq)*sqrt2pi);
            n_1 = exp(-((O(bseq)-1)^2)/(2*sigma_squared(bseq)))/(sigma(bseq)*sqrt2pi);

            term = log(p*(n_1 - n_0) + n_0); 
            logl = logl + term;
        end

        L(iseq,pseq+1) = logl;
    end
end

[max_L max_L_inds] = max(L');
 

%%  Plots the results   --- DO NOT ALTER CODE ---

figure;

for isize = 1:length(N_bits)
    
    plot(p_H, L(isize,:), 'Color', colors{isize});
    hold on;
    plot(p_H(max_L_inds(isize)), max_L(isize), '*', 'MarkerEdgeColor', colors{isize});
    
end

xlabel('p_H');
ylabel('likelihood');
title('2.3.b: blue: 100 trials, green: 500, red: 1000, black: 2500');

print('hw2.3.b.pdf','-dpdf')
