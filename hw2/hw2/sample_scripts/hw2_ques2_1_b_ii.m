% Homework 2, Question 2, 1.b.ii
%
% Fill in the missing code below!
%
% --- DO NOT ALTER CODE ---

clear all;

N_bits = 3;
p_H = 0:0.01:1;  % sample p_H
seqs = {[1 1 1], [1 1 0], [0 0 1], [0 0 0]}; % cell array of observed sequences
L = [];  % L: num_seqs x num_ph_samples, each row corresponds to the
         % likelihood vs. p_H plot
max_L = [];  % max_L: num_seqs x 1, keeps track of the maximum likelihood 
max_L_inds = []; % num_seqs x 1, keeps track of index in p_H with max likelihood
colors = {[0 0 1], [0 1 0], [1 0 0], [0 0 0]}; % colors for the lines
         
%% FILL IN THE MISSING CODE HERE
%
%  --- ALTER THIS CODE ---

N_Hs = cellfun(@sum, seqs);

for iseq = 1:length(seqs)

    N_H = N_Hs(iseq);
    
    for pseq = 0:1:100
        p = pseq/100; 
        L(iseq, pseq+1) = p^N_H * (1-p)^(N_bits-N_H);
    end

    sum(L(iseq,:))/100
end

[max_L max_L_inds] = max(L');

%%  Plots the results   --- DO NOT ALTER CODE ---

figure;

for iseq = 1:length(seqs)
    
    plot(p_H, L(iseq,:), 'Color', colors{iseq});
    hold on;
    plot(p_H(max_L_inds(iseq)), max_L(iseq), '*', 'MarkerEdgeColor', colors{iseq});
    
end

xlabel('p_H');
ylabel('likelihood');
title('2.1.b.ii: blue: 111, green: 110, red: 001, black: 000');

print('hw2.1.b.ii.pdf','-dpdf')
