%The stoichiometric matrix of the network
S = [-1  1  0  0; 
      1 -1 -1  1; 
      0  0  1 -1];
%--------------------------------------------------------------------------
%The vector of initially provided rate constants
k = [0.0100; 0.3333; 1.500; 0.3820];
%--------------------------------------------------------------------------
%The vector of initially provided Michaelis constants
K = [50; 500; 22; 18; 78];
%--------------------------------------------------------------------------
%The vector of initially provided initial species concentratios
x_0 = [500; 0; 0];          x_0(x_0 == 0) = realmin;
%--------------------------------------------------------------------------
%The right endpoint of the interval of interest
T = 1500;
%--------------------------------------------------------------------------
%Division of the time interval of interest for reaction rates
mu_1 = 5;
%--------------------------------------------------------------------------
%Division of the time interval of interest for reaction rates
mu_2 = 500;
%--------------------------------------------------------------------------
%The overall reaction rates are given in terms of unidirectional reaction
%rates by the following matrix
H = [-1  1  0  0;
      0  0 -1  1];
%--------------------------------------------------------------------------
%The standard deviation of the white Gaussian noise that is used to
%perturb the data corresponding to y
sigma = 0.02;
%--------------------------------------------------------------------------
%Randomly generated test matrix
x_test = [500.0000  453.6200  443.1676  439.7262  438.4877  438.0317;
          0.0000    10.5427   12.1018   12.5831   12.7532   12.8154;
          0.0000    35.8364   44.7281   47.6876   48.7555   49.1490];
%--------------------------------------------------------------------------
%Randomly generated test vectors
K_test = K;
%k_test = k;
k_test = [0.02; 0.4; 1.6; 0.38];
%--------------------------------------------------------------------------
save('GH_PKC')
