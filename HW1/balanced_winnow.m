function [ acc_winnow , CM , acc_winnow_test  ] = balanced_winnow( S_train , S_test , n , nu , I )
%Balanced winnow as specified in the problem
%   S_train is the training set
%   S_test is the testing set
%	n is the number of values in each point
%   nu is a scalar parameter that alters the speed weighting
%   I is the number of epochs that are run
% A confusion matrix and accuracy output for test values
% A running plot of accuracy is also output

% Variable initialization
pervar = n + 1;
w_p = double(1/(2*n))*double(ones(1,n));
w_n = double(1/(2*n))*double(ones(1,n));
acc_winnow = double(ones(1,I));
len_train = size(S_train,1);
len_test = size(S_test,1);

for i = 1:I
   
    for j = 1:len_train
        
        val = S_train(j,1)*(dot((w_p.'),S_train(j,2:pervar)) - dot((w_n.'),S_train(j,2:pervar)));
        if val <= 0
            w_p = w_p.*exp( nu * S_train(j,1) * S_train(j,2:pervar));
            w_n = w_n.*exp( -nu * S_train(j,1) * S_train(j,2:pervar));
            s = sum([w_p w_n]);
            w_p = w_p./s;
            w_n = w_n./s;
            
            acc_winnow(i) = acc_winnow(i) - 1/len_train;
        end
    end
    
end

CM = zeros(2,2);

for i = 1:len_test
    %Finds val and categorizes inputs
    val = (dot((w_p.'),S_test(i,2:pervar)) - dot((w_n.'),S_test(i,2:pervar)));
    if val >= 0 && S_test(i,1) == 1
        CM(1,1) = CM(1,1) + 1;
    elseif val >= 0 && S_test(i,1) == -1
        CM(1,2) = CM(1,2) + 1;
    elseif val < 0 && S_test(i,1) == 1
        CM(2,1) = CM(2,1) + 1;
    else
        CM(2,2) = CM(2,2) + 1;
    end
end
acc_winnow_test = (CM(1,1) + CM(2,2))/sum(sum(CM));

end

