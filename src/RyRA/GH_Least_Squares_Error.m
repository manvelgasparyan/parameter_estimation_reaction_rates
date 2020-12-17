%The following function corresponds to the least square error. It is a
%function of two variables x and y, where x is the vector of independent
%variables and y is the vector of dependent variables whose values are
%found by observations.The output of the function is the least square error
%==========================================================================
function [error] = GH_Least_Squares_Error (x,y)
%The Output
  error = 0;
%--------------------------------------------------------------------------
%n is the number of independent variables and m is the number 
%of observations available from experiments   
  [n,m] = size(x);
%--------------------------------------------------------------------------
%The fit of the model to a data point is measured by its residual r_ij, 
%defined as the difference between the actual value of the independent 
%variable x(i,j) and the value y(i,j) predicted by the model
  for i = 1:n
      for j = 1:m
          r_ij = (x(i,j) - y(i,j))^2;
          error = error + r_ij;
      end
  end
%--------------------------------------------------------------------------
end
