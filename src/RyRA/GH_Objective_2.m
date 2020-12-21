function [objective] = GH_Objective_2(k, S, x, w, H)
    %-----------------------------------------------
    %The number of time points
    [~,N] = size(x);
    %-----------------------------------------------
    %The substrate composition matrix
    Delta = -min(S,0);
    %-----------------------------------------------
    %The vector of reaction rates
    phi = exp(Delta'*log(x));
    Gamma_k = diag(k);
    v = Gamma_k*phi;
    %-----------------------------------------------
    %The output, whic is the vector of overall 
    %outgoing reactio rates
    y = H*v;
    %-----------------------------------------------
    %The error between the available experimental 
    %data and the corresponding model-predicted data
    objective = GH_Least_Squares_Error(y,w);
end
