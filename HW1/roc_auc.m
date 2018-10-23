function [ roc , auc ] = roc_auc( w , S_test , n , scale , iter )
%Determines the ROC curve and calculates the AUC
%   w is our seperating hyperplane
%   S_test is whatever test set we are using to generate it
%   iter is the number of points on our roc curve
%   n is the number of variables per point
% Outputs are the ROC and AUC
% AUC is calculated as the data is approximated by looking at the
% difference in FPR and multiplying it with the TPR and adding it
% to a sum.

%Initialize variables
roc = double(zeros(2,iter));
tests = size(S_test,1);
pervar = n + 1;
last_fpr = 0;
last_tpr = 0;
auc = 0;

for i = 1:iter
    
    %Determine b value for given iteration using max/scale
    half = double(iter/2);
    b = scale*double(i - half)/half;
    
    %Create a confusion matrix for determining tpr and fpr
    CM = double(zeros(2,2));
    for j = 1:tests
        val = dot((w.'),S_test(j,2:pervar))+b;
        if val >= 0 && S_test(j,1) == 1
            CM(1,1) = CM(1,1) + 1;
        elseif val >= 0 && S_test(j,1) == -1
            CM(1,2) = CM(1,2) + 1;
        elseif val < 0 && S_test(j,1) == 1
            CM(2,1) = CM(2,1) + 1;
        else
            CM(2,2) = CM(2,2) + 1;
        end
    end
    
    %Create the roc curve
    roc(1,i) = CM(1,2) / ( CM(1,2) + CM(2,2) );
    roc(2,i) = CM(1,1) / ( CM(1,1) + CM(2,1) );
    %Use trapezoidal to estimate the auc value
    auc = auc + (last_tpr + roc(2,i))*(roc(1,i) - last_fpr)/2;
    last_fpr = roc(1,i);
    last_tpr = roc(2,i);
end

end
