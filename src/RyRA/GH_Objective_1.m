%The following corresponds to the first objective function that is used to 
%derive data for species concentrations. It is a function of five variables
%x_hat, S, T, t_int, Lambda, where x_hat is the parameter matrix of
%reaction rates, S is the stoichiometric matrix of the network, T is the 
%right-hand side of the time interval, t_int is the time interval, and
%Lambda is the observed time-series data of reaction rates available from
%biological experiments.
%==========================================================================
function [objective] = GH_Objective_1(x_hat, Index, H, S, mu_2, T, y_hat)
%The function corresponding to our model
F = @(tau,nu)GH_Intermediate(tau, nu, S, x_hat, T);
%--------------------------------------------------------------------------
t_span = 0:T/mu_2:T;
%--------------------------------------------------------------------------
%The initial reaction rates
v_0 = lsqnonneg(H,y_hat(:,1));
v_0(v_0==0)=10^(-5);
%--------------------------------------------------------------------------
%The model-provided values
options = odeset('AbsTol', 1e-4);
[~,v] = ode23tb(F, t_span, v_0, options);
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
