function [ acc_train, acc_test , w ] = perceptron( S_train , S_test , n , I )
% perceptron function as defined in HW 1
% classifies 4 as -1, and 9 as 1
%   S_train is the training set
%   S_test is the testing set
%   n is the number of values in each point
%   I is the number of epochs that are run
% acc is the overtime determination of accuracy
% for both test and training sets
% w is the final result, or approximated w_sep

%Initializations
pervar = n + 1;
w = double(zeros(1,n));
acc_train = double(ones(1,I));
acc_test = double(ones(1,I));
len_train = size(S_train,1);
len_test = size(S_test,1);

%Epoch loop
for i = 1:I
    
    %Loop for training set
    for j = 1:len_train
        %Determine value for perceptron equation
        val = S_train(j,1)*dot((w.'),S_train(j,2:pervar));
        if val <= 0
            w = w + S_train(j,1).*S_train(j,2:pervar);
            %update accuracy plot
            acc_train(i) = acc_train(i) - 1/len_train;
        end
    end
    
    %Loop for testing set, accuracy updates
    for j = 1:len_test
        val = S_test(j,1)*dot((w.'),S_test(j,2:pervar));
        if val < 0
            acc_test(i) = acc_test(i) - 1/len_test;
        end
    end
end

end

    

