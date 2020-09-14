% hdd_plantparam_v1.m  Parameter file of Hard Disk Drive Ver.1.0
%
%   Copyright (c) 2004-2005, MSS benchmark working group
%   Copyright (c) 2006-, HDD benchmark working group
%   Ver.1.0a, 2007-08-31

% Author(s): M.Hirata, T.Hara
% Ver.1.0  2006-12-05
% Ver.1.0a 2007-08-31 remove 'beta version' from Comment

ModelName = 'HDD Benchmark Model Ver.1.0';
Comment = '';

% Physical parameters
m  = 1e-3;	      % Equivalent mass of head actuator [kg]
Tp = 2.54e-7;	      % Width of track [m] 100kTPI
%Lc = Rs/(2*pi*4e4);   % Inductance of VCM
%Rc = 8;               % Equivalent resistance of VCM [Ohm]
Kf = 0.9512;	      % Equivalent Force constant [N/A]
Kg = Kf/m;	      % Input gain [m/(s^2A)]
Kp = 1/Tp*Kf/m;
DeltaKp = [0, 10, -10]/100; % Gain perturbation (percent)

% Rotation speed of disk and sampling time
rpm       = 7200;                % rotational speed
num_servo =  220;                % Number of servo per track
Ts        = 60/rpm/num_servo;    % Sampling time of Position Error Signal (PES)
Tc        = Ts;                  % Sampling time of control input
Ty        = Ts;                  % Sampling time at plant output
Tu        = Ts/2;                % Sampling time at plant input
Td        = 10.0e-6;             % Input delay [s]

% Nominal parameters of mechanical vibration modes
MechFn0   = [   90,  4100,  8200, 12300, 16400,  3000,  5000 ]; % [Hz]
MechZeta0 = [  0.5,  0.02,  0.02,  0.02,  0.02, 0.005, 0.001 ];
MechGain0 = [  1.0,  -1.0,   1.0,  -1.0,   1.0,  0.01,  0.03 ];
    
% Perturbations for nominal values (multiplicative error)
DeltaFn   = [    0,     0,     0,     0,     0,     0,     0 ;
                 0,    15,    15,    10,    10,     5,     5 ;
                 0,   -15,   -15,   -10,   -10,    -5,    -5 ;
                 0,    15,   -15,   -10,    10,     5,     5 ;
                 0,   -15,    15,    10,   -10,    -5,    -5 ]/100; % percent
DeltaZeta = [    0,     0,     0,     0,     0,     0,     0 ]/100; % percent
DeltaGain = [    0,     0,     0,     0,     0,     0,     0 ;
                 0,     0,     0,     0,     0,  -200,  -200 ]/100; % percent

% Index matrix to generate perturbed plant
pert_idx = [
     1     1     1
     1     1     2
     2     1     1
     2     1     2
     3     1     1
     3     1     2
     4     1     1
     4     1     2
     5     1     1
     5     1     2
 ];

np=size(pert_idx,1);
MechFn   = ones(np,1)*MechFn0.*(1+DeltaFn(pert_idx(:,1),:));
MechZeta = ones(np,1)*MechZeta0.*(1+DeltaZeta(pert_idx(:,2),:));
MechGain = ones(np,1)*MechGain0.*(1+DeltaGain(pert_idx(:,3),:));

%% EOF of hdd_plantparam_v1.m
