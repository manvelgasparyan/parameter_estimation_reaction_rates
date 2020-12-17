%The following function corresponds to our initial value problem of the 
%reaction rates of the considered biochemical reaction network. It is a 
%function of four variables t, x, v and S, where t is the time variable, x
%is the vector of species' %concentrations which is approximated by the 
%vector of Bezier curves Gamma, v is the vector of reaction rates, and S is 
%the stoichiometric matrix, T is the right-hand side of the time interval. 
%The output of the function is the right-hand side of our new initial value
%problem.
%==========================================================================
function [dv_dt] = GH_Intermediate (t, v, S, x_hat, T)
%--------------------------------------------------------------------------
%The number of species/parameters
[s,~] = size(x_hat);
%--------------------------------------------------------------------------
%Approximation of species concentrations with the shifted Bezier curves
for i = 1:s
    x_i = x_hat(i,:);
    gamma_i = GH_Bezier_curve(t, T, x_i);
    Gamma(i) = gamma_i;
end
%--------------------------------------------------------------------------
%The diagonal matrix of the shifted Bezier curves
Gamma_b = diag(Gamma);
%--------------------------------------------------------------------------
%The diagonal matrix of reaction rates
Gamma_v = diag(v);
%--------------------------------------------------------------------------
%The substrate composition matrix
Delta = - min(S,0);
%--------------------------------------------------------------------------
%The right-hand side of our initial value problem
dv_dt = Gamma_v*Delta'*inv(Gamma_b)*S*v;
end
