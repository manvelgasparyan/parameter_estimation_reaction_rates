%The following corresponds to the first objective function that is used to 
%derive data for species concentrations. It is a function of five variables
%x_hat, S, T, t_int, Lambda, where x_hat is the parameter matrix of
%reaction rates, S is the stoichiometric matrix of the network, T is the 
%right-hand side of the time interval, t_int is the time interval, and
%Lambda is the observed time-series data of reaction rates available from
%biological experiments.
%==========================================================================
function [objective] = GH_Objective_1(q, theta, Index, H, S, mu2, T, y_hat)
%--------------------------------------------------------------------------
[s,~] = size(S);
%--------------------------------------------------------------------------
[~,N] = size(y_hat);
%--------------------------------------------------------------------------
K_hat = theta(1:q);
%--------------------------------------------------------------------------
for i = 1:s
    x_hat(i,:) = theta(q+(i-1)*N+1:q+i*N)';
end    
%--------------------------------------------------------------------------
%The function corresponding to our model
F = @(tau,nu)GH_Intermediate(tau, nu, S, x_hat, T, K_hat);
%--------------------------------------------------------------------------
t_span = 0:T/mu2:T;
%--------------------------------------------------------------------------
%The initial reaction rates
v_0 = lsqnonneg(H,y_hat(:,1));
v_0(v_0==0)=10^(-5);
%--------------------------------------------------------------------------
%The model-provided values
[~,v] = ode23tb(F, t_span, v_0);
v = v';
%--------------------------------------------------------------------------
v = v(:,Index);
%--------------------------------------------------------------------------
y = H*v;
%--------------------------------------------------------------------------
%The output is the least square error, which is a function of the available
%experimental time-series data of reaction rates and the corresponding 
%model-provided values
objective = GH_Least_Squares_Error(y,y_hat);
end
%===============================END========================================
