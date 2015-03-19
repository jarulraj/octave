function [ ns, fs, xs, gains ] = getWeightedInfoGainForStumps( X, Y, D )
%GETWEIGHTEDINFOGAINFORSTUMPS Compute the weighted info gain 
% for every possible split along every possible dimension. 
% 
% Output: 
% A list of ns splits and associated gains, each split i described via:
%   fs(i) - the feature along which we split
%   xs(i) - the value according to which we split Xi <= xs(i), Xi > xs(i)
%   gains(i) - the information gain obtained by splitting acording to fs(i), xs(i)
% fs, xs, gains are vectors of equal size (ns x 1), equal to the
% total # of distinct splits. 
% 
% NOTE: "All possible splits along dimension i" = all splits obtained by 
% sorting X according to coordinate i, and taking the midpoint 
% between each two consecutive distinct points. As not all points may be 
% distinct, the total # of splits ns migth be < n*k. 

    n = size(X,1);
    k = size(X,2);
    ni = 1;
    ns = 0;
    zz = ones(1,1);

    % Pre-allocate max memory we might need for efficiency 
    fs = zeros((n-1)*k,1); 
    xs = zeros((n-1)*k,1);
    gains = zeros((n-1)*k,1);

    % Marginal entropy
    y_pos = find(Y == +1);
    p_y_pos = 0;
    for i=1:n
        if Y(i) == +1
            p_y_pos = p_y_pos + D(i);
        end
    end
    p_y_neg = 1-p_y_pos;

    aa = 0;
    if p_y_pos != 0
       aa = p_y_pos*log2(p_y_pos);
    end
    if p_y_neg != 0
       bb = p_y_neg*log2(p_y_neg);
    end

    H_y = -(aa+bb);

    for i=1:k
        X_i_sort = sort(X(:,i));
        X_i_unique = unique(X_i_sort);

        l = length(X_i_unique);
        ns = ns + l - 1;

        for j=1:l-1
            mid = (X_i_unique(j) + X_i_unique(j+1))/2.0;
            
            fs(ni) = i;
            xs(ni) = mid;
            
            % Conditional entropy

            % LT
            x_i_le_t_ind = find(X(:,i) <= mid);
            l_le_t = length(x_i_le_t_ind);
            p_le_t = 0;
            y_pos_le_t = 0;

            for z = 1:l_le_t
                offset = x_i_le_t_ind(z);

                p_le_t = p_le_t + D(offset);
                
                if Y(offset) == +1
                    y_pos_le_t = y_pos_le_t + D(offset);
                end
            end

            if p_le_t == 0
                p_y_pos_le_t = 0;
            else
                p_y_pos_le_t = y_pos_le_t/p_le_t;
            end
            p_y_neg_le_t = 1 - p_y_pos_le_t;

            % GT
            x_i_gt_t_ind = find(X(:,i) > mid);
            l_gt_t = length(x_i_gt_t_ind);
            p_gt_t = 0;
            y_pos_gt_t = 0;

            for z = 1:l_gt_t
                offset = x_i_gt_t_ind(z);
                
                p_gt_t = p_gt_t + D(offset);
                
                if Y(offset) == +1
                    y_pos_gt_t = y_pos_gt_t + D(offset);
                end
            end

            if p_gt_t == 0
                p_y_pos_gt_t = 0;
            else
                p_y_pos_gt_t = y_pos_gt_t/p_gt_t;
            end
            p_y_neg_gt_t = 1 - p_y_pos_gt_t;
                                           
            % Information Gain
            aa = 0;
            bb = 0;
            cc = 0;
            dd = 0;

            if p_y_pos_le_t != 0
                aa = p_y_pos_le_t * log2(p_y_pos_le_t);
            end
            if p_y_neg_le_t != 0
                bb = p_y_neg_le_t * log2(p_y_neg_le_t);
            end
            if p_y_pos_gt_t != 0
                cc = p_y_pos_gt_t * log2(p_y_pos_gt_t);
            end
            if p_y_neg_gt_t != 0
                dd = p_y_neg_gt_t * log2(p_y_neg_gt_t);
            end

            %p_y_pos_le_t
            %p_y_neg_le_t
            %p_y_pos_gt_t
            %p_y_neg_gt_t
            %aa
            %bb
            %cc
            %dd
            %p_le_t
            %p_gt_t

            H_y_i = -( (p_le_t * (aa + bb)) + (p_gt_t * (cc + dd)));
            I_y_i = H_y - H_y_i;

            gains(ni) = I_y_i;
            ni = ni + 1;
        end
    end
    
    % Only return the ns splits (remove zero padding we pre-allocated)
    fs = fs(1:ns);
    xs = xs(1:ns);
    gains = gains(1:ns);

    ns;
    fs;
    xs;
    gains;

end

%feval('getWeightedInfoGainForStumps', [1, 5; 1, 5; 1, -5], 
%                                     [ -1; -1; +1], 
%                                      [0.25; 0.5; 0.25])

%feval('getWeightedInfoGainForStumps', [-1.02, 1; -2, 1; 1, 2; 1, 1; 1, 1; -3, 1; 1, 1; 1, 1], 
%                                     [ 1; -1; 1; -1; 1; 1; 1; 1], 
%                                      [0.125; 0.125; 0.125; 0.125; 0.125; 0.125; 0.125; 0.125])
