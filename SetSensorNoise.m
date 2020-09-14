function [SensorNoise] = SetSensorNoise(PlantData,DistParam);
%SetSensorNoise  Set sensor noise in time and frequency domain
%   [SensorNoise] = SetSensorNoise(PlantData,DistParam);
%
%   Copyright (c) 2004-2005, MSS benchmark working group
%   Copyright (c) 2006-, HDD benchmark working group
%   Ver.3.0 2006-12-05

% Author(s): M.Hirata, T.Hara
% Ver.1.0 2006-06-06 created by M.Hirata
% Ver.3.0 2006-12-05

% simulation parameters
num_servo          = PlantData.num_servo;
num_sim_revolution = DistParam.num_sim_revolution;
Ts                 = PlantData.Ts; % PES Sampling
% seeds for random signal
Seed_SensorNoise  = DistParam.Seed_SensorNoise;

% Frequency vector is defined by PES sampling frequency
Freq = DistParam.Freqs;
NUM  = DistParam.Nums;

% Sensor noise in time domain
NUM_SensorNoise = num_servo*num_sim_revolution;
randn('state',Seed_SensorNoise);
Data = whitenoise(NUM_SensorNoise,Ts)*DistParam.AmpSensorNoise;
Time = (0:NUM_SensorNoise-1)'*Ts;

% Sensor noise in frequency domain
Spec = DistParam.AmpSensorNoise*ones(NUM,1);

% Output parameters in time domain
SensorNoise.Data = Data;
SensorNoise.Time = Time;
SensorNoise.Ts   = Ts;
% Output parameters in frequency domain
SensorNoise.Freq = Freq;
SensorNoise.Spec = Spec;

%% EOF of SetSensorNoise.m
