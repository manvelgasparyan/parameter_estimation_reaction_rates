%The inputs corresponding to the model of RyRA
%--------------------------------------------------------------------------
%The stoichiometric matrix of the network
S = [-1  1 -1  1 -1  1; 
      0  0  1 -1  0  0; 
      1 -1  0  0  0  0; 
      0  0  0  0  1 -1];
%--------------------------------------------------------------------------
%The vector of initially provided rate constants
k = [28.8; 984.15; 1093.5; 385.9; 1.75; 0.1];
%--------------------------------------------------------------------------
%The vector of initially provided initial species concentratios
x_0 = [0; 0; 0.963; 0.037];           x_0(x_0 == 0) = realmin;
%--------------------------------------------------------------------------
%The right endpoint of the interval of interest
T = 10;
%--------------------------------------------------------------------------
%Division of the time interval of interest for reaction rates
mu_1 = 5;
%--------------------------------------------------------------------------
%Division of the time interval of interest for reaction rates
mu_2 = 500;
%--------------------------------------------------------------------------
%The overall reaction rates are given in terms of unidirectional reaction
%rates by the following matrix
H = [-1  1  0  0  0  0;
      0  0  1 -1  0  0;
      0  0  0  0  1 -1];
%--------------------------------------------------------------------------
%The standard deviation of the white Gaussian noise that is used to
%perturb the data corresponding to y
sigma = 0.02;
%--------------------------------------------------------------------------
%Randomly generated test matrix
x_test = [0    0.1    0.07    0.06    0.05    0.05; 
          0    0.3    0.19    0.15    0.13    0.14;
          0.96 0.003  0.002   0.002   0.001   0.001;
          0.04 0.56   0.74    0.79    0.8     0.82];
%--------------------------------------------------------------------------
%Randomly generated test vector
k_test = [10; 20; 30; 40; 50; 60];
%--------------------------------------------------------------------------
save('GH_RyRA')
