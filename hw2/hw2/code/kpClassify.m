function [ c ] = kpClassify( XTrain, XTest, w, d )
    nTest = size(XTest,1);
    nTrain = size(XTrain,1);
    c = zeros(nTest,1);

    K = [];
    for i = 1:nTest
        for j = 1:nTrain
            K(i, j) = dot(XTest(i,:), XTrain(j,:))^d;
        endfor
    endfor

    for i = 1:nTest
        X = XTest(i,:);
 
        th = 0;
        for j = 1:nTrain
            th = th + w(j) * K(i, j);
        endfor

        if th > 0
            c(i) = +1;
        else
            c(i) = -1;
        endif
    end

end

#feval('kpClassify', [0.1, 0.5, 11; 0.3, 0.2, 1.4; 0.1, 0.6, 1.3], [0.1, 0.6, 13; 0.4, 0.1, 0.1], [-1, -6, 4], 3)
