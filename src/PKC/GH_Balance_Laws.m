function [dx_dt] = GH_Balance_Laws (~, x, k, K, S)
   %----------------------------------------------
   %The substrate composition matrix
   Delta = - min(S,0);
   %----------------------------------------------
   %The diagonal matrix of rate constants
   Gamma_k = diag(k);
   %----------------------------------------------
   %The substrate expressiion function
   phi = exp(Delta'*log(x));
   %----------------------------------------------
   %The diagonal of rational terms
   g = GH_Denominator(x, K);
   Gamma_g = diag(g);
   %----------------------------------------------
   %The vector og reaction rates
   v = Gamma_k*Gamma_g*phi;
   %----------------------------------------------
   %The balance laws
   dx_dt = S*v;
end
