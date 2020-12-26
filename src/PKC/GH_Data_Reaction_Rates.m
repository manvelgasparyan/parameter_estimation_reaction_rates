function [t, y_hat] = GH_Data_Reaction_Rates (k, K, S, H, T, mu_1, x_0, sigma)
   %-----------------------------------------------------------------------
   %The time interval of interest [0,T] divided by N_1 = mu_1+1 points
   t_span_1 = 0:T/mu_1:T;
   %-----------------------------------------------------------------------
   %The balance laws corresponding to the chemical reaction network
   f_1 = @(t,x)GH_Balance_Laws (t, x, k, K, S);
   %-----------------------------------------------------------------------
   %The concentrations of the species participating in the network
   [t, x] = ode23tb(f_1, t_span_1, x_0);
   x = x';
   %-----------------------------------------------------------------------
   %The substrate composition matrix
   Delta = - min(S,0);
   %-----------------------------------------------------------------------
   %The substrate expression function
   phi  = exp(Delta'*log(x));
   %-----------------------------------------------------------------------
   %The diagonal of rational terms
   g = GH_Denominator(x, K);
   Gamma_g = diag(g);
   %-----------------------------------------------------------------------
   %The diagonal matrix of rate constants
   Gamma_k = diag(k);
   %-----------------------------------------------------------------------
   %The vector of reaction rates
   v = Gamma_k*Gamma_g*phi;
   %-----------------------------------------------------------------------
   %The overall outgoing reaction rates in a direction specified by H
   y = H*v;
   %-----------------------------------------------------------------------
   if sigma == 0
      y_hat = y;
   else
   %-----------------------------------------------------------------------
   %Perturbation of the data corresponding to y with moyenne mean and sigma
   %standard deviation
   moyenne = 0; 
   %-----------------------------------------------------------------------
   %Generating a randow white Gaussian noise. Note that every time this
   %noise will be different, which means that the final result will also be
   %different
   matrix = [0.8147    0.1270    0.6324    0.2785    0.9575    0.1576;
             0.9058    0.9134    0.0975    0.5469    0.9649    0.9706];
   %-----------------------------------------------------------------------
   %White Gaussian noise of zero mean and sigma standard devation
   noise = moyenne + sigma*matrix;
   %-----------------------------------------------------------------------
   %Perturbation of data y withh white Gaussian noise
   y_hat = y + noise;  
   end
   %-----------------------------------------------------------------------
end
