 function [] = testSpam()

    Mail = cell(3,1);
    
    Mail{1} = {'Maintain' ; 'ad!!!!' ; 'the' ; 'in' ; 'count' ; 'sex' ; 'password'; 'sex'}; 
    Mail{2} = {'Win' ; 'win!!!!!!' ; 'system' ; 'Maintain' ; 'address' ; 'the' ; 'expire' ; 'of' ; '  '}; 
    Mail{3} = {'win' ; 'viagra' ; 'is' ; ' '; 'almost' ; 'full' ; 'now'; 'of' ; 'of' ; '*'}; 
  
    mail2Feat(Mail)
end

feval('testSpam')
