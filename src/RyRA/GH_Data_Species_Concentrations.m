function [x_hat] = GH_Data_Species_Concentrations (mu_1, mu_2, T, H, S, y_hat, x_test)
   %Time division for the available data
   t_1 = 0:T/mu_1:T;
   %------------------------------------------------------------
   %Time division for the model-predicted data
   t_2 = 0:T/mu_2:T;
   %------------------------------------------------------------
   N_2 = mu_2 + 1;
   %------------------------------------------------------------
   N_1 = mu_1 + 1;
   %------------------------------------------------------------
   Index = zeros(1,N_1);
   for i = 1:N_1
       for j = 1:N_2
           if t_1(i) == t_2(j)
           Index(i) = j; 
           end
       end
   end
   %--------------------------------------------------------------
   x_test(x_test == 0) = 10^(-5);
   %---------------------------------------------------------------
   e = @(xi_hat)GH_Objective_1(xi_hat, Index, H, S, mu_2, T, y_hat);
   %---------------------------------------------------------------
   options = optimset('MaxFunEvals',500);
   %---------------------------------------------------------------
   %Data of species' concentrations 
   x_hat = fminsearch(e,x_test, options);
end
