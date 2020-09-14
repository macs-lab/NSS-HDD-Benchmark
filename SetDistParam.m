function [DistParam] = SetDistParam(PlantData,fname);
%SetDistParam  Define parameters for noise and disturbance
%   [DistParam] = SetDistParam(PlantData,fname);
%
%   Copyright (c) 2004-2005, MSS benchmark working group
%   Copyright (c) 2006-, HDD benchmark working group
%   Ver.3.0 2006-12-05

% Author(s): M.Hirata, H.Uchida, T.Hara
% Ver.1.0 2005-04-23
% Ver.1.1 2005-04-26
% Ver.1.2 2005-05-10 refine dist. parameters by H.Uchida
% Ver.1.3 2005-05-12 refine dist. parameters by T.Hara
% Ver.1.4 2005-05-13 refine flutter & RRO dist. by T.Hara
% Ver.2.0 2006-02-13 change file name for new version
% Ver.3.0 2006-12-05

% Check input argument
if nargin < 2
    error('SetDistParam(PlantData,fname');
end

% Data from plant model
rpm = PlantData.rpm;
Ts  = PlantData.Ts;
Tu  = PlantData.Tu;
Ty  = PlantData.Ty;
Fns = 1/Ts/2; % Nyquist freq. of PES sampling
Fnu = 1/Tu/2; % Nyquist freq. of plant input
Fny = 1/Ty/2; % Nyquist freq. of plant output

% Run parameter file
if exist(fname,'file') ~= 2
    error(['The parameter file [' fname '] does not exist'])
else
    eval(fname);
end

% Check frequency resolution
if ( (Fns/dFs) ~= fix(Fns/dFs) )
    error('Frequency resolution dF0s is not appropriate')
end
if ( (Fnu/dFu) ~= fix(Fnu/dFu) )
    error('Frequency resolution dF0u is not appropriate')
end
if ( (Fny/dFy) ~= fix(Fny/dFy) )
    error('Frequency resolution dF0y is not appropriate')
end
Nums  = Fns/dFs;
Numu  = Fnu/dFu;
Numy  = Fny/dFy;
Freqs = dFs*(1:Nums)';
Frequ = dFu*(1:Numu)';
Freqy = dFy*(1:Numy)';

% Check RROSequence
if ~exist('RROSequence','var')
    RROSequence = zeros(PlantData.num_servo,1);
end

% ModelName and Comment
DistParam.ModelName = ModelName;
DistParam.Comment   = Comment;

% The length of simulation
DistParam.num_sim_revolution = num_sim_revolution;
% Frequency vector
DistParam.Nums              = Nums;
DistParam.Numu              = Numu;
DistParam.Numy              = Numy;
DistParam.dFs               = dFs;
DistParam.dFu               = dFu;
DistParam.dFy               = dFy;
DistParam.Freqs             = Freqs;
DistParam.Frequ             = Frequ;
DistParam.Freqy             = Freqy;
% Sensor noise
DistParam.AmpSensorNoise    = AmpSensorNoise;
% Force disturbance
DistParam.AmpForceDist      = AmpForceDist;
% Flutter disturbance
DistParam.AmpFlutterDist    = AmpFlutterDist;
DistParam.FlutterFreq       = FlutterFreq;
% DistParam.FlutterFreqSigma  = FlutterFreqSigma; % used ???
DistParam.FlutterFreqZeta   = FlutterFreqZeta;
% RRO disturbance
DistParam.FreqRRO           = FreqRRO;
DistParam.AmpRRO            = AmpRRO;
DistParam.RROSequence       = RROSequence;
% Seeds for random signal
DistParam.Seed_ForceDist    = Seed_ForceDist;
DistParam.Seed_SensorNoise  = Seed_SensorNoise;
DistParam.Seed_FlutterDist  = Seed_FlutterDist;
DistParam.Seed_RRODist      = Seed_RRODist;

%% EOF of SetDistParam.m
