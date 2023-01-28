function [estInt, intervals] = adapSimpsonsNonRecursive(f, a, b, tol)
% In this section, we first defined our function

candh_interms = [a b];
% We have stated that our candidate values are between a and b values
intervals = [];
% We first defined the intervals as the empty set
estInt = 0;
% We defined the estİnt variable as 0 to start from 0.
while   ~isempty(candh_interms)
% Since the while command continues as long as the given condition is met, 
% we have written this condition to continue as long as the candidate intervals values are not empty.
        [m,n] = size(candh_interms);
% Since the row and column numbers of the Candidate values are unknown, 
% we have printed the column and row numbers to the system with the command        
        candh_interms1=[];
% With this command, we opened a copy of the candidate value set and saved the values
% here as long as the loop rotates so that the queue does not disappear
        for i=1: m 
% In the For loop, I said i=1 because the loop will not end until the desired value is reached, 
% and the number of rows will increase one by one until it reaches the value of m, and when
% the number of rows ends, it will exit the loop.            
            entleft = candh_interms(i,1);
% this is how I defined the first value of the i. line            
            entright = candh_interms(i,2);
% this is how I defined the second value of the i. line            
            c = (entleft+entright)/2;
% we found their midpoint
            estIntMain1 = intSimpsons(@keskin19,entleft,entright);
            estIntLeft1 = intSimpsons(@keskin19,entleft,c);
            estIntRight1 = intSimpsons(@keskin19,c,entright);
% We defined the estInt values by taking them from the intsompson so that we reached
% the integrals of these values without needing an extra loop.           
            
            
            if abs(estIntMain1-estIntLeft1-estIntRight1) <= (15 * tol)                %do not divide
               
               estInt = estInt + estIntLeft1 + estIntRight1 + (estIntLeft1+estIntRight1-estInt)*(1/15);
               
               intervals = [intervals ; entleft c; c entright];
% It prints the processed values at intervals.
            else %divide
               candh_interms1=[candh_interms1; entleft c; c entright];
% Divides the intervals in the process when the if condition is not met.               
            end
% i defined an if and else expression to determine whether a partition should be made if it meets the required conditions,
% and I wrote the statements that were previously given to us in the stopping criteria.

                         
        end    

        candh_interms = candh_interms1;
% Prints the copy to the original
        tol = tol/2;   
% Each cycle divides the tolerance in half.
end