function [ w ] = pWeights( XTrain, yTrain, nIter)

    nTrain = size(XTrain,1);
    nFeat = size(XTrain,2);
    w = zeros(nFeat,1);

    for iter = 1:nIter
        for i = 1:nTrain
            x_i = XTrain(i,:);
            y_i = yTrain(i);

            if y_i * (x_i * w) <= 0
                w = w + y_i * x_i'; 
            endif
        end
    end

end

#feval('pWeights', [0.1, 0.5, 11; 0.3, 0.2, 1.4; 0.1, 0.2, 1.3], [+1; -1; +1], 20)

