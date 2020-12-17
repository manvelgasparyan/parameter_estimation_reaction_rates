function [objective] = GH_Objective_2(k, S, x, w, H)
[~,N] = size(x);
Delta = -min(S,0);
for i = 1:N
    v(:,i) = diag(k)*exp(Delta'*log(x(:,i))); 
end
phi = exp(Delta'*log(x));
Gamma_k = diag(k);
v = Gamma_k*phi;
y = H*v;
objective = GH_Least_Squares_Error(y,w);
end
