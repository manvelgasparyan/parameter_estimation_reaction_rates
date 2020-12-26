%The following function corresponds to Bezier curve defined by control
%points F over the pre-specified interval [0,T]. It is a function of three 
%variables t, T and F, where t is the time variable, T is the length of the 
%intevral and is the vector of control points.
%==========================================================================
function [beta] = GH_Bezier_curve (t, T, F)
%The number of control points
  N = numel(F);
%--------------------------------------------------------------------------
%The output
  beta = 0;
%--------------------------------------------------------------------------
for m = 1:N
    %The binomial coefficient
    C_Nm = nchoosek(N-1,m-1);
    %The Bernstein polynomial
    b_Nm = C_Nm*t^(m-1)*(T-t)^(N-m);
    %The linear combination of Bernstein polynomials
    beta = beta + b_Nm*F(m);
end
%--------------------------------------------------------------------------
%The average over time of the aforementioned linear combination is the
%Bezier curve defined by control points F over interval [0,T]
beta = beta/T^(N-1);
end
