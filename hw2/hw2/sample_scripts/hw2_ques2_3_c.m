% Homework 2, Question 2, 3.c
%
% Fill in the missing code below!

clear all;

p_H_star = 0.6; % the value of the true parameter
sigma_squared = [];  % the variance, you'll need to define this (i/2)
p_H = 0:0.01:1; % sample p_H
N_bits = [100 500 1000 2500]; % trial size varies
L = [];  % L: num_trial_sizes x num_ph_samples, each row corresponds to the
         % likelihood of one trial size vs. p_H plot
max_L = [];  % max_L: num_trial_sizes x 1, keeps track of the maximum likelihood 
max_L_inds = []; % num_trial_sizes x 1, keeps track of index in p_H with max likelihood
colors = {[0 0 1], [0 1 0], [1 0 0], [0 0 0]}; % colors for the lines

p_H_hat = []; % 1 x num_trial_sizes: MLE
p_H_bar = []; % 1 x num_trial_sizes: # O_i > 0.5 / N_bits

%rng(10701); % sets the random seed to produce identical output each time
         

%% FILL IN THE MISSING CODE HERE
 
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
 
    N_higher = 0;
    for bseq = 1:N_bit
        if O(bseq) > 0.5
            N_higher = N_higher+1;
        end
    end
 
    p_H_bar(iseq) = N_higher/N_bit ; 
end

[max_L max_L_inds] = max(L');
 
for iseq = 1:length(N_bits)
    [max_L max_L_inds] = max(L(iseq,:));
    p_H_hat(iseq) = p_H(max_L_inds);
end
 
p_H_hat
sumdiff = 0;
for iseq = 1:length(N_bits)
    sumdiff = sumdiff + abs(p_H_hat(iseq) - p_H_star);
end
sumdiff

p_H_bar
sumdiff = 0;
for iseq = 1:length(N_bits)
    sumdiff = sumdiff + abs(p_H_bar(iseq) - p_H_star);
end
sumdiff


%%  Plots the results 
%   Requires p_H, seqs, and L

figure;

plot(N_bits, p_H_hat, 'Color', colors{1});
hold on;
plot(N_bits, p_H_bar, 'Color', colors{2});

plot([min(N_bits) max(N_bits)], [p_H_star p_H_star], '--k');

ylim([0 1]);
xlabel('trial size');
ylabel('p_H');
title('2.3.c: blue: p-H-hat, green: p-H-bar');

print('hw2.3.c.pdf','-dpdf')
