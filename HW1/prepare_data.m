function [ set ] = prepare_data( set1 , set2 , n , norm)
%This functions prepares data by combining the two sets
%and randomly distributing the indexes of the sets
% set1 is mapped to -1
% set2 is mapped to 1
% norm is the maximum value in the set
% n is the number of values in each point
rng(2018)

%Apply the classifier to the set and combine into one training set
%Also sets the sets to doubles
app = -ones(size(set1,1),1);
set1_app = [app double(set1)];
app = ones(size(set2,1),1);
set2_app = [app double(set2)];
set_nrand = [set1_app ; set2_app];
%Randomize the order of the training set
set_nnorm = set_nrand(randperm(length(set_nrand)),:);
%Norms the sets, maintaining classifiers
norm_dbl = double(norm);
pervar = n + 1;
set(:,1) = set_nnorm(:,1);
set(:,2:pervar) = set_nnorm(:,2:pervar)./norm_dbl;

end

