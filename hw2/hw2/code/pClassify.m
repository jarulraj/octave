function [ c ] = pClassify( XTest, w)
    
    nTest = size(XTest,1);
    c = zeros(nTest,1);
    
    for iter = 1:nTest
        X = XTest(iter,:);

        if X * w > 0
            c(iter) = +1;
        else
            c(iter) = -1;
        endif
    end

end

#feval('pClassify', [0.1, 0.8, 10; 0.5, 0.2, 1.2], [-0.38; 0.04; 0.06])
