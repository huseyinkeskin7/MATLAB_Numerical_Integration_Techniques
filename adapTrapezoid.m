function [estInt, intervals] = adapTrapezoid(f, a, b, tol)
% i defined our equality to the system with the help of the function command

c = (a+b)/2;
% I wrote this line to find the midpoint of the a and b interval,
% and defined it as the value of c as requested in the task.

estIntMain = intTrapezoid(f,a,b);
% i defined the output value according to the values of a and b as the estIntMain variable

estIntRight = intTrapezoid(f,a,c);
% i defined the output value according to the values of a and c as the estIntRight variable

estIntLeft = intTrapezoid(f,c,b);
% i defined the output value according to the values of c and b as the estIntLeft variable
% With these commands, we have divided the algorithm into two.

if  abs(estIntMain-estIntRight-estIntLeft) <= (7 * tol)
    % According to the task, if a result of the code on the top line is correct, the equation
    % on the bottom line will be performed and the execution will end, but if not, it will switch
    % to the else command. This stopping criteria was used as given to us in the task.

    estInt = estIntRight + estIntLeft + (1/7)*(estIntRight+estIntLeft-estIntMain);

    intervals = [a c ; c b];
    % i have defined the entire space a c, c b that I divide as the intervals variable.

else
    [estIntRight, intervals1] = adapTrapezoid(f,a,c,tol/2);

    [estIntLeft, intervals2] = adapTrapezoid(f,c,b,tol/2);
    %   i called gap of a c and c b adaptively and assumed the tolerance value 
    %   as half of the total tolerance
   
    estInt = estIntRight + estIntLeft;
    
    intervals = [intervals1 ; intervals2];
    % I have divided intervals
    % in this way in order to store all the rows separately.
end