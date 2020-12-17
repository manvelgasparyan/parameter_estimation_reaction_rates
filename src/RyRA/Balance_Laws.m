function [dx_dt] = GH_Balance_Laws (~, x, k, S)
   %----------------------------------------
   %The substrate composition matrix
   Delta = - min(S,0);       
   %----------------------------------------
   %The diagonal matrix of rate constants
   Gamma_k = diag(k);
   %----------------------------------------
   %The substrate expression function
   phi = exp(Delta'*log(x));
   %----------------------------------------
   %The vector of reaction rates
   v = Gamma_k*phi;
   %----------------------------------------
   %The balance laws
   dx_dt = S*v;
end
