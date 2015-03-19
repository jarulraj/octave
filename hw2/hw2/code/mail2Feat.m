function [ Feats ] = mail2Feat( Mail )

    nMail = size(Mail,1)
    Feats = ones(nMail,1); 

    % load data from dictionary.csv file
    fid = fopen('dictionary.csv');    
    tline = fgetl(fid);
    dict = strread(tline,'%s','delimiter',',');
    mailLen = [];

    % compute tf/idf
    nWords = length(dict)
    tf = [];
    idf = [];
 
    % set up the feature matrix.
    nFeat = nWords;
    Feats = [zeros(nMail,nFeat),ones(nMail,1)]; 
    mailLen = [];

    for j = 1:nMail
        mailLen(j) = size(Mail{j},1);
    end

    for i = 1:nWords
        d_count = 0;
        w = dict{i};

        for j = 1:nMail 
            w_count = sum(strcmp(Mail{j},w)); 
            tf(i, j) = w_count/mailLen(j);
            
            if w_count > 0
                d_count = d_count + 1;
            endif
        end
        
        if d_count == 0
            d_count = nMail;
        endif

        idf(i) = log(nMail/d_count);

        for j = 1:nMail
            Feats(j, i) = tf(i, j) * idf(i);
        end
    end
    
end

