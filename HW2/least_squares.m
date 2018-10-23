function [ lse ] = least_squares( test , stumps)
%Finds the least squared error across the set
%   test is the data test set
%   stubs is the list of x_indexes and directions for the split

len = size(test,1);
var_len = size(test,2);
stub_len = size(stumps,1);
tot_err = 0.0;

for i = 1:len
    
    err = 0.0;
    % act  test(ind) * dir 
    
    %Number of errors
    for j = 1:stub_len
        err = err + ~xor(test(i,var_len),xor(test(i,stumps(j,1)),stumps(j,2)));
    end
    tot_err = tot_err + (err/stub_len)^2;
end
lse = double(tot_err)/double(len);

end
