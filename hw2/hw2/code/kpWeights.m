function [ w ] = kpWeights( XTrain, yTrain, nIter, d )
    
    nTrain = size(XTrain,1);
    nFeat = size(XTrain,2);
    w = zeros(nTrain,1);
    K = [];

    for i = 1:nTrain
        for j = 1:nTrain
            K(i, j) = dot(XTrain(i,:),XTrain(j,:))^d;
        endfor
    endfor

    for iter = 1:nIter
        for i = 1:nTrain
            y_i = yTrain(i);
            x_i = XTrain(i,:);
        
            th = 0;
            for j = 1:nTrain
                th = th + w(j) * K(i, j);
            endfor
    
            if th > 0
                cur = +1;
            else
                cur = -1;
            endif
    
            if cur ~= y_i
                w(i) = w(i) + y_i; 
            endif
        end
    end

end

#feval('kpWeights', [0.1, 0.5, 11; 0.5, 1.2, 1.4; 0.2, 0.3, 13], [+1; -1; +1], 5000, 3)
 
