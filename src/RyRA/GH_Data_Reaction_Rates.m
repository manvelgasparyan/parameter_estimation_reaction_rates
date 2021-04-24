function [t, y_hat] = GH_Data_Reaction_Rates (k, S, H, T, mu_1, x_0, sigma)
   %-----------------------------------------------------------------------
   %The time interval of interest [0,T] divided by N_1 = mu_1+1 points
   t_span_1 = 0:T/mu_1:T;
   %-----------------------------------------------------------------------
   %The balance laws corresponding to the chemical reaction network
   f_1 = @(t,x)GH_Balance_Laws (t, x, k, S);
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
   %The diagonal matrix of rate constants
   Gamma_k = diag(k);
   %-----------------------------------------------------------------------
   %The vector of reaction rates
   v = Gamma_k*phi;
   %-----------------------------------------------------------------------
   %The overall outgoing reaction rates in a direction specified by H
   y = H*v;
   %-----------------------------------------------------------------------
   %Perturbation of the data corresponding to y with moyenne mean and sigma
   %standard deviation
   moyenne = 0; 
   %-----------------------------------------------------------------------
   if sigma == 0
      y_hat = y;
   else
   %-----------------------------------------------------------------------
   %Generating a random white Gaussian noise. Note that every time this
   %noise will be different, which means that the final result will also be
   %different
   matrix = [0.6948    0.0344    0.7655    0.4898    0.7094    0.6797;
             0.3171    0.4387    0.7952    0.4456    0.7547    0.6551;
             0.9502    0.3816    0.1869    0.6463    0.2760    0.1626];
   %-----------------------------------------------------------------------
   %White Gaussian noise of zero mean and sigma standard devation
   noise = moyenne + sigma*matrix;
   %-----------------------------------------------------------------------
   %Perturbation of data y withh white Gaussian noise
   y_hat = y + noise;  
   end
end
