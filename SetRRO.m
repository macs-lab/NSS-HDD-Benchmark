function [RRO] = SetRRO(PlantData,DistParam);
%SetRRO  Set repeatable runout (RRO)
%   [RRO] = SetRRO(PlantData,DistParam);
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
Seed_RRODist      = DistParam.Seed_RRODist;
% Frequency vector is defined by PES sampling frequency
Freq = DistParam.Freqs;
NUM  = DistParam.Nums;

% RRO dist. in time domain
NUM_RRODist = num_servo*num_sim_revolution;
rand('state',Seed_RRODist); % Here is rand command (not randn)
[num_RRODist] = length(DistParam.FreqRRO);
RRODistOT  = zeros(num_servo,1);
RRODistT   = (0:NUM_RRODist-1)'*Ts;
RRODistOTT = RRODistT(1:num_servo,1);
for ii=1:num_RRODist
    Frro = DistParam.FreqRRO(ii);
    Arro = DistParam.AmpRRO(ii);
    ph_lag = rand(1)*2*pi;
    RRODistOT = RRODistOT + sin(2*pi*Frro*RRODistOTT + ph_lag)*Arro; % fixed (Ver.1.1)
end
RRODistOT = RRODistOT + DistParam.RROSequence;
RRODist = zeros(NUM_RRODist,1);
for ii=1:num_sim_revolution
    sidx = (ii-1)*num_servo + 1;
    eidx = sidx + num_servo - 1;
    RRODist(sidx:eidx,1) = RRODistOT;
end

% RRO dist. in frequency domain
Spec    = zeros(NUM,1);
[N_RRO] = length(DistParam.FreqRRO);
cc      = 0;
for(jj=1:N_RRO)
    ii = find(Freq == DistParam.FreqRRO(jj));
    if(ii > 0)
        Spec(ii(1)) = DistParam.AmpRRO(jj);
        cc = cc + 1;
    end
end
if ( cc ~= N_RRO )
    error('Frequency vector Freqs is not correct')
end

% Output parameters in time domain
RRO.Data = RRODist;
RRO.Time = RRODistT;
RRO.Ts   = Ts;
% Output parameters in frequency domain
RRO.Freq = Freq;
RRO.Spec = Spec;

%% EOF of SetRRO.m
