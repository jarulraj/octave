function [] = process()

    fid = fopen('spam.txt'); 
    spam = textscan(fid, '%s');

    fid2 = fopen('stop.csv'); 
    tline = fgetl(fid2);
    stop = strread(tline,'%s','delimiter',',');

    spam{1} = unique(spam{1});
    spam{1} = strtrim(spam{1});
    spam{1} = spam{1}(~cellfun(@isempty, spam{1}))
    spam{1} = unique(spam{1});

    spam{1} = setdiff(spam{1}, stop);

    fileId = fopen('dictionary.csv', 'w');
    [nrows,ncols] = size(spam{1});

    for row = 1:nrows
        fprintf(fileId,'%s,', spam{1}{row,:});
    end

    fclose(fileId);
end

feval('process');
