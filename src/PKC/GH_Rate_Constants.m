function [k_hat] = GH_Rate_Constants (mu_1, T, K_hat, S, x_hat, k_test)
    e_2 = @(k)GH_Objective_2(x_hat, k, K_hat, S, mu_1, T)*any(k>0);
    %------------------------------------------------------------
    k_hat = fminsearch(e_2,k_test);
end


