function [ m_1, m_2 ] = ls_2method( test , stumps)
%Finds the least squared error across the set
%   test is the data test set
%   stubs is the list of x_indexes and directions for the split
% method 1 is the output for finding the least squares with majority vote
% method 2 is the average error

%Lengths
len = size(test,1);
var_len = size(test,2);
stub_len = size(stumps,1);

%List of error for average
stub_err = zeros(stub_len,1);

%total error for total error determination
tot_err = 0.0;

for i = 1:len

    %votes for an outcome of 0
    votes = 0;
    for j = 1:stub_len
        %votes for total error outcome
        votes = votes + xor(test(i,stumps(j,1)),stumps(j,2));
        
        %summing error for each variable
        iserr = ~xor(test(i,var_len),xor(test(i,stumps(j,1)),stumps(j,2)));
        stub_err(j) = stub_err(j) + double(iserr)/double(len);
    end
    %Voting
    if votes > stub_len/2
        tot_err = tot_err + test(i,var_len);
    else
        tot_err = tot_err + ~test(i,var_len);
    end
end
%Final averaging
m_1 = double(tot_err)/double(len);
m_2 = sum(stub_err)/double(stub_len);
end
