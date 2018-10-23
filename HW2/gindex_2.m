function [ gindex_out , dir , err ] = gindex_2( training )
%Performs gini index calculations for a set of data
%   training is the set that is being input
% Outputs gini index over range of values for each input

len = size(training,1);
var_len = size(training,2)-1;
gindex_out = zeros(1,var_len);
dir = zeros(1,var_len);


%Determines Initial gini index
p = 0.0;
for j = 1 : len
    if training(j,size(training,2)) == 1
        p = p + 1.0;
    end
end
p = p/double(len);
I = 2.0*p*(1.0-p);
    
for k = 1 : var_len
        
    %Tracks - [number of yes, agreed yes, classified no but actually yes]
    p = double(zeros(1,3));
        
    for j = 1 : len
       if training(j,k) == 1
           %If the input is above the current classifier threshold
           p(1) = p(1) + 1.0;
               
           if training(j,size(training,2)) == 1
               p(2) = p(2) + 1.0;
           end
       else
           if training(j,size(training,2)) == 1
               p(3) = p(3) + 1.0;
           end
       end 
    end
    
    %Determines a final gini index for each variable
    if len ~= p(1)
        gindex_out(k) = I - 2*(p(1)/len)*(p(2)/p(1))*(1 - (p(2)/p(1))) - 2*(1 - p(1)/len)*(p(3)/(len - p(1)))*(1 - (p(3)/(len - p(1))));
    else
        gindex_out(k) = 0;
    end
    
    %Sets the direction of the classifier
    if (p(3)+p(1)-p(2))<(len-p(1)-p(3)+p(2))
        dir(k) = 1.0;
    end
    
end
    
end

