% hdd_distparam_v1.m  Parameter file of HDD disturbance Ver.1.0
%
%   Copyright (c) 2004-2005, MSS benchmark working group
%   Copyright (c) 2006-, HDD benchmark working group
%   Ver.1.0b 2007-08-31

% Author(s): M.Hirata, T.Hara
% Ver.1.0  2006-06-06 created by M.Hirata
% Ver.1.0a 2006-12-05
% Ver.1.0b 2007-08-31

ModelName = 'HDD Benchmark Model Ver.1.0';
Comment = '';

% Frequency resolution
dFs = 6; % Frequency resolution of PES
dFu = 6; % Frequency resolution of plant input
dFy = 6; % Frequency resolution of plant output

% The length of disturbance
num_sim_revolution = 1000;

% Scaling parameter
scl = sqrt(2*Ts);

% Sensor noise
AmpSensorNoise = 1.5e-2*scl; % unit:[Track], 1 sigma of Sensor Noise

% Force disturbance
AmpForceDist = 1.0e-4*scl; % unit:[A] at control input, 1 sigma of Torque Noise with sampling Ts

% Flutter & Suspension etc.
% Flutter dist.
%   Mode   Freq.
%   (0,0)   900
%   (0,1)-  900-120
%   (0,1)+  900+120
%   (0,2)-  990-240
%   (0,2)+  990+240
%   (0,3)- 1440-360
%   (0,3)+ 1440+360
% Suspension etc.
%   Freq: 3000, 5000Hz
FlutterFreq       = [  750,  780,  900, 1020, 1080, 1230, 1800, 3000, 5000];
% FlutterFreqSigma  = [   40,   30,   30,   30,   40,   40,   40,   50,   50];
FlutterFreqZeta   = [ 0.01, 0.01, 0.01, 0.01,0.005, 0.01,0.005,0.002,0.002];
AmpFlutterDist    = [ 0.09, 0.17, 0.20, 0.17, 0.06, 0.09, 0.06, 0.06, 0.12]*scl;

% RRO
FreqRRO     = [ 1,  2,  3]*(rpm/60);  % Frequency [Hz]
AmpRRO      = [0.15, 0.03, 0.006];    % unit:[Track] at PES, Amplitude of each RRO component
if exist('RROSequence.mat','file')
    load RROSequence;
end

% Seed for random signal
Seed_ForceDist    = 1;
Seed_SensorNoise  = 2;
Seed_FlutterDist  = 3;
Seed_RRODist      = 4;

%% EOF of hdd_distparam_v1.m
