clear; clc; close;
%==========================================================================
%PAGE 1: Inputs
%-----------------------
Model = load('GH_RyRA');
%-----------------------
S = Model.S; 
%-----------------------
k = Model.k; 
%-----------------------
x_0 = Model.x_0;
%-----------------------
T = Model.T;
%-----------------------
mu_1 = Model.mu_1;
%-----------------------
H = Model.H;
%-----------------------
sigma = Model.sigma;
%==========================================================================
%==========================================================================
%PAGE 2: Derivation of data corresponding to the overall outgoing reaction
%rates in a direction specified by H
%-----------------------------------------------------------------
%The data corresponding tot he overall outgooing reaction rates in 
%directions specified by H
[t, y] = GH_Data_Reaction_Rates (k, S, H, T, mu_1, x_0, sigma);
%-----------------------------------------------------------------
[l,~] = size(H);
%-----------------------------------------------------------------
%Division of the time interval of interest
N_1 = mu_1 + 1;
%-----------------------------------------------------------------
%{
figure(1)
for i = 1:l
    subplot(1,3,i)
    for j = 1:N_1
        plot(t(j), y(i,j), 'x', 'linewidth', 2, 'color', 'r');
        hold on
    end
    hold off
    grid on
    grid minor  
    caption1 = sprintf('Experimental data');
    caption2 = sprintf('Overall outgoing reaction rates %d', i);
    legend(caption1)
    set(gca,'FontSize',12)
    xlabel({'Time','(in seconds)'})
    title(caption2)
end
%}
%==========================================================================
%==========================================================================
save('GH_Available_Experimental_Data')
