function [ gindex_out ] = gindex( training , res , r1 , r2 )
%Performs gini index calculations for a set of data
%   training is the set that is being input
%   res is the resolution of the training set
%   r1 and r2 represent the range of values
% Outputs gini index over range of values for each input

if r2 <= r1
    disp( 'r2 needs to be bigger than r1')
    return
end

len = size(training,1);
var_len = size(training,2)-1;
gindex_out = zeros(res,var_len);

for i = 1 : res
    
    p = 0.0;
    for j = 1 : len
        if training(j,size(training,2)) == 1
            p = p + 1.0;
        end
    end
    p = p/double(len);
    I = 2.0*p*(1.0-p);
    
    for k = 1 : var_len
        
        %Tracks - [number of points above the threshold, 3 point shots
        %above threshold, 3 point shots below threshold]
    	p = double(zeros(1,3));
        
    	for j = 1 : len
           currval = double(r1) + (double(r2)-double(r1))*double(i)/double(res);
           if training(j,k) >= currval
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
        
        if len ~= p(1)
            gindex_out(i,k) = I - 2*(p(1)/len)*(p(2)/p(1))*(1 - (p(2)/p(1))) - 2*(1 - p(1)/len)*(p(3)/(len - p(1)))*(1 - (p(3)/(len - p(1))));
        else
            gindex_out(i,k) = 0;
        end

    end
    
end

