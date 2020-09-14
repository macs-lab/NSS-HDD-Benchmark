function [PlantData] = SetPlantModel(fname,options);
%SetPlantModel  Define Plant Models for Both Following and Seeking Control
%   [PlantData] = SetPlantModel(fname,options);
%
%   Copyright (c) 2004-2005, MSS benchmark working group
%   Copyright (c) 2006-, HDD benchmark working group
%   Ver.3.0 2006-12-05

% Author(s): M.Hirata, H.Uchida, T.Hara
% Ver.1.0 2005-04-23
% Ver.1.1 2005-05-02
% Ver.1.1 2005-05-12 refine plant parameters by T.Hara
% Ver.1.2 2005-05-16 refine perturbations of physical parameters by M.Hirata
% Ver.2.0 2006-02-12 new mechanical vibration model
% Ver.3.0 2006-12-05 

if nargin < 1
    error('File name of parameter file should be specified');
elseif nargin < 2
    options.seekmode = 0;
elseif nargin > 2
    error('SetPlantModel(fname,[options]);');
end

% Run parameter file
if exist(fname,'file') ~= 2
    error(['The parameter file [' fname '] does not exist'])
else
    eval(fname);
end

if options.seekmode == 0
else
    MechFn(:,1)   = 0;
    MechZeta(:,1) = 0;
    MechGain(:,1) = 1;
end

% Nominal model (reduced-order)
[PnMech] = make_plant(MechFn(1,1), MechZeta(1,1), MechGain(1,1));

% Full-order model
[PfMech,PfMechMode] = make_plant(MechFn(1,:), MechZeta(1,:), MechGain(1,:));

% Full-order model with variation
nn = size(pert_idx,1);
for ii=1:nn
    [PfpertMech(1,1,ii)] = ...
        make_plant(MechFn(ii,:), MechZeta(ii,:), MechGain(ii,:));
end

% Plant models
Pn     = (1/Tp)*PnMech*Kg;      % nominal
Pf     = (1/Tp)*PfMech*Kg;      % full-order
Pfpert = (1/Tp)*PfpertMech*Kg;  % full-order w/ variation
% Plant models (decomposed mode)
PfMode = (1/Tp)*PfMechMode*Kg;      % full-order

% Set input delay property
set(Pn,'InputDelay',Td);
set(Pf,'InputDelay',Td);
set(PfMode,'InputDelay',Td);
set(Pfpert,'InputDelay',Td);

% ModelName and Comment
PlantData.ModelName = ModelName;
PlantData.Comment   = Comment;

% Physical parameters
PlantData.m          = m;
PlantData.Tp         = Tp;
% PlantData.Rs         = Rc;
% PlantData.Ls         = Ls;
PlantData.Kf         = Kf;
PlantData.Kg         = Kg;
PlantData.Kp         = Kp;
% PES
PlantData.rpm        = rpm;
PlantData.num_servo  = num_servo; % fixed (Ver.1.1)
PlantData.Ts         = Ts;
%PlantData.Tc         = Tc; % (default)
PlantData.Ty         = Ty; % Ver.2.0
PlantData.Tu         = Tu; % Ver.2.0
PlantData.Td         = Td;
% Mechanical resonance modes
PlantData.MechFn     = MechFn;
PlantData.MechZeta   = MechZeta;
PlantData.MechGain   = MechGain;
% Plant models
PlantData.Pn     = Pn;
PlantData.Pf     = Pf;
PlantData.Pfpert = Pfpert;
% Plant models (Input: [m/s^2], output: [m])
PlantData.PnMech     = PnMech;
PlantData.PfMech     = PfMech;
PlantData.PfpertMech = PfpertMech;
% Plant models (decomposed mode)
PlantData.PfMode         = PfMode;
PlantData.PfMechMode     = PfMechMode;
% Model perturbation
PlantData.DeltaKp     = DeltaKp;
%PlantData.DeltaFn     = DeltaFn;
%PlantData.DeltaZeta   = DeltaZeta;
%PlantData.DeltaGain   = DeltaGain;

%% EOF of SetPlantModel.m
