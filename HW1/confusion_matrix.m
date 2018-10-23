function [ CM , max ] = confusion_matrix( w , S_test, n)
%Finds a confusion matrix for the data and a given test set
% w is the hyperplane
% S_test is the set with the classifier appended to the front
%CM is confusion matrix output
%max is the maximum value after weights are applied to w

%initializes CM, max, other vars
CM = zeros(2,2);
tests = size(S_test,1);
pervar = n + 1;
max = 0;

for i = 1:tests
    %Finds val and categorizes inputs
    val = dot((w.'),S_test(i,2:pervar));
    if val >= 0 && S_test(i,1) == 1
        CM(1,1) = CM(1,1) + 1;
    elseif val >= 0 && S_test(i,1) == -1
        CM(1,2) = CM(1,2) + 1;
    elseif val < 0 && S_test(i,1) == 1
        CM(2,1) = CM(2,1) + 1;
    else
        CM(2,2) = CM(2,2) + 1;
    end
    %Updates maximum weighted val
    if abs(val) > max
        max = abs(val);
    end
end

end

