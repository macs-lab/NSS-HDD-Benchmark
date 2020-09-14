function [FlutterDist] = SetFlutterDist(PlantData,DistParam);
%SetFlutterDist  Set flutter disturbance in time and frequency domain
%   [FlutterDist] = SetFlutterDist(PlantData,DistParam);
%
%   Copyright (c) 2004-2005, MSS benchmark working group
%   Copyright (c) 2006-, HDD benchmark working group
%   Ver.3.0 2006-12-05

% Author(s): M.Hirata, T.Hara
% Ver.1.0 2006-06-06 created by M.Hirata
% Ver.3.0 2006-12-05

% Read parameters
AmpFlutterDist     = DistParam.AmpFlutterDist;
FlutterFreq        = DistParam.FlutterFreq;
FlutterFreqZeta    = DistParam.FlutterFreqZeta;
num_servo          = PlantData.num_servo;
num_sim_revolution = DistParam.num_sim_revolution;
Ts                 = PlantData.Ts; % PES Sampling
Ty                 = PlantData.Ty; % Plant output
% Seeds for random signal
Seed_FlutterDist  = DistParam.Seed_FlutterDist;
% Frequency vector is defined by PES sampling frequency
Freq = DistParam.Freqs;
NUM  = DistParam.Nums;

% sys_FlutterDist
lg = length(AmpFlutterDist);
for ii=1:lg
    w_f    = 2*pi*FlutterFreq(ii);
    zeta_f = FlutterFreqZeta(ii);
    pk_f   = AmpFlutterDist(ii);
    sys_FlutterDist(ii) = tf( pk_f*2*zeta_f*w_f^2,[1 2*zeta_f*w_f w_f^2] );
end

% Flutter dist. in time domain
if fix(Ts/Ty) ~= (Ts/Ty)
    error('Ts/Ty must be integer');
end
NUM_FlutterDist = num_servo*num_sim_revolution; % Ver.2.0
randn('state',Seed_FlutterDist);
Data = zeros(NUM_FlutterDist,1);
Time = (0:NUM_FlutterDist-1)'*Ty; % Ver.2.0
for ii=1:lg
    sys_FlutterDist0 = sys_FlutterDist(ii);
    FlutterDistIn = whitenoise(NUM_FlutterDist,Ty); % Ver.2.0
    Data = Data + lsim(sys_FlutterDist0,FlutterDistIn,Time);
end
dcidx     = 1:(Ts/Ty):NUM_FlutterDist;
DataAtPes = Data(dcidx); % down sampling by (Ts/Ty)
TimeAtPes = (0:length(DataAtPes)-1)'*Ts;

% Flutter dist in frequency domain
Spec2 = zeros(NUM,1);
for ii=1:lg
    [mag,phs] = bode(sys_FlutterDist(ii), 2*pi*Freq );
    Spec2 = Spec2 + mag(:).^2;
end
Spec  = sqrt( Spec2 );

% Output parameters in time domain
FlutterDist.Data      = Data;
FlutterDist.Time      = Time;
FlutterDist.Ts        = Ty;
FlutterDist.DataAtPes = DataAtPes;
FlutterDist.TimeAtPes = TimeAtPes;
FlutterDist.TsAtPes   = Ts;
% Output parameters in frequency domain
FlutterDist.Freq      = Freq;
FlutterDist.Spec      = Spec;

%% EOF of SetFlutterDist.m
