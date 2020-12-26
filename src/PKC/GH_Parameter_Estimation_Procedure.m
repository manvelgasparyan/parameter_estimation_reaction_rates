%==========================================================================
%PAGE 1: Inputs
%-----------------------
Data = load('GH_Available_Experimental_Data');
%-----------------------
Model = load('GH_PKC');
%-----------------------
y_hat = Data.y;
%-----------------------
S = Model.S; 
%-----------------------
T = Model.T;
%-----------------------
mu_1 = Model.mu_1;
%-----------------------
mu_2 = Model.mu_2;
%-----------------------
H = Model.H;
%-----------------------
x_test = Model.x_test;
%-----------------------
K_test = Model.K_test;
%-----------------------
k_test = Model.k_test;
%==========================================================================
%PAGE 2: Derivation of data corresponding to the species concentrations
%--------------------------------------------------------------------------
[K_hat, x_hat] = GH_Data_Species_Concentrations (mu_1, mu_2, T, S, H, K_test, y_hat, x_test) 
%==========================================================================
%PAGE 3: Derivation of rate constants
%--------------------------------------------------------------------------
k_hat = GH_Rate_Constants (mu_1, T, K_hat, S, x_hat, k_test)
%==========================================================================
%PAGE 4: Observed experimental time-series data of reaction rates (in red) 
%of the model of ryanodine receptor adaptation and the corresponding 
%predicted values of reaction rates (in blue) of the model with parameters 
%estimated by our method.
%--------------------------------------------------------------------------
%The vector of initial concentrations derived from our estimation method
x_0 = x_hat(:,1);
%--------------------------------------------------------------------------
%Time interval for the experimental data
t_hat = 0:T/mu_1:T;
%--------------------------------------------------------------------------
[t_pred, y_pred] = GH_Data_Reaction_Rates (k_hat, K_hat, S, H, T, mu_2, x_0, 0);
%--------------------------------------------------------------------------
[l,~] = size(H);
%--------------------------------------------------------------------------
N_1 = mu_1 + 1;
%--------------------------------------------------------------------------
figure(2)
for i = 1:l
    subplot(1,l,i)
    plot(t_pred, y_pred(i,:), 'color', 'b', 'linewidth', 1.5)
    hold on
    for j = 1:N_1
        plot(t_hat(j),y_hat(i,j),'x', 'color', 'r', 'linewidth', 2)
        hold on
    end
    hold off
    grid on
    grid minor     
    caption1 = sprintf('Experimental data');
    caption2 = sprintf('Predicted values');
    caption3 = sprintf('Overall outgoing reaction rate %d', i);
    legend(caption2, caption1)
    set(gca,'FontSize',12)
    xlabel({'Time','(in seconds)'})
    ylabel({caption3,'(in nM s^{-1})'})
end
%==========================================================================
%PAGE 5: The Least Squares Error between the observed time-series
%experimenatl data and the corresponding model predicted data
%--------------------------------------------------------------------------
[~, z] = GH_Data_Reaction_Rates (k_hat, K_hat, S, H, T, mu_1, x_0, 0);
Error = GH_Least_Squares_Error(z,y_hat)
%==========================================================================
