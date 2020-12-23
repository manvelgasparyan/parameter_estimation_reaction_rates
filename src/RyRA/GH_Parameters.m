function [k_hat] = GH_Parameters (k_test, S, x_hat, y_hat, H)

    Error = @(k)GH_Objective_2(k, S, x_hat, y_hat, H)*any(k>0);
  
    k_hat = fmincon(Error, k_test, [], [], [], [], 0, [], []);
end
