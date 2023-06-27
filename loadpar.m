%
% script to load parameters for exercise 4;
% the values are then stored in the following arrays
%
% z   - depth points of shear-wave velocity
% vs0 - starting model of shear-wave velocity
% vst - true shear-wave velocity model
% T   - periods for phase velocities
% vf0 - reference phase velocities
% vfm - measured phase velocitites
% dvf - residual phase velocitites
%

%%% load starting model (S-velocity as a function of depth):
dat = load('vs0t.dat');
z   = dat(:,1);
vs0 = dat(:,2);
vst = dat(:,3);


%%% phase velocity as a function of period, predicted by starting model:
dat = load('phasevf.dat');
T   = dat(:,1);
vf0 = dat(:,2);
vfm = dat(:,3);     % Measured phase velocity as a function of period: 
dvf = vfm - vf0;    % Data (residual phase velocity as a function of period): 


%%% define size of the problem
n = length(vfm);    % number of data (rows):
k = length(vs0);    % number of model parameters (number of columns):


%%% compute layer thicknesses:
d = zeros(size(z));
d(1) = 0.5*(z(2) - z(1));    %% first and last entries
d(k) = 0.5*(z(k) - z(k-1));
for i = (2:k-1)
  d(i) = 0.5*(z(i+1) - z(i-1));
end


%%% read matrix with partial derivatives of phase velocity to S-velocity,
%%% and set up G
dcdb = load('Gdcdb.dat') ;
for i = (1:n)
    for j = (1:k)
        Gt(j,i) = dcdb(j,i)*d(j) ;
    end
end
G = Gt';


%%%
%%% End of script to load parameters and setup G-matrix
%%%