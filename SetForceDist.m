function [ForceDist] = SetForceDist(PlantData,DistParam);
%SetForceDist  Set force disturbance in time and frequency domain
%   [ForceDist] = SetForceDist(PlantData,DistParam);
%
%   Copyright (c) 2004-2005, MSS benchmark working group
%   Copyright (c) 2006-, HDD benchmark working group
%   Ver.3.0 2006-12-05

% Author(s): M.Hirata, T.Hara
% Ver.1.0 2006-06-06 created by M.Hirata
% Ver.3.0 2006-12-05

% Read parameters
AmpForceDist       = DistParam.AmpForceDist;
num_servo          = PlantData.num_servo;
num_sim_revolution = DistParam.num_sim_revolution;
Ts                 = PlantData.Ts; % PES Sampling
Tu                 = PlantData.Tu; % Plant input
% Seeds for random signal
Seed_ForceDist  = DistParam.Seed_ForceDist;
% Frequency vector is defined by PES sampling frequency
Freq = DistParam.Freqs;
NUM  = DistParam.Nums;

% Force dist. in time domain
if fix(Ts/Tu) ~= (Ts/Tu)
    error('Ts/Tu must be integer');
end
NUM_ForceDist = num_servo*num_sim_revolution*(Ts/Tu);
randn('state',Seed_ForceDist);
Data       = whitenoise(NUM_ForceDist,Tu)*DistParam.AmpForceDist;
Time       = (0:NUM_ForceDist-1)'*Tu;
% dist at PES
DistOut    = lsim(PlantData.Pn,Data,Time);
dcidx      = 1:(Ts/Tu):NUM_ForceDist;
DataAtPes  = DistOut(dcidx); % down sampling by (Ts/Tu)
TimeAtPes  = (0:length(DataAtPes)-1)'*Ts;

% Force dist. in frequency domain
Spec      = DistParam.AmpForceDist*ones(NUM,1);
[mag,phs] = bode( PlantData.Pn*DistParam.AmpForceDist, 2*pi*Freq );
SpecAtPes = mag(:);

% Output parameters in time domain
ForceDist.Data      = Data;
ForceDist.Time      = Time;
ForceDist.Ts        = Tu;
ForceDist.DataAtPes = DataAtPes;
ForceDist.TimeAtPes = TimeAtPes;
ForceDist.TsAtPes   = Ts;
% Output parameters in frequency domain
ForceDist.Freq      = Freq;
ForceDist.Spec      = Spec;
ForceDist.SpecAtPes = SpecAtPes;

%% EOF of SetForceDist.m
