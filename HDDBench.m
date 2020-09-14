% HDDBench.m  Main m-script for hard disk benchmark problem
%
%   Copyright (c) 2004-2005, MSS benchmark working group
%   Copyright (c) 2006-, HDD benchmark working group
%   Ver.3.1, 2007-08-31

% Derived from main.m
% Author(s): M.Hirata, T.Hara
% Ver.1.0 2005-04-26
% Ver.1.1 2005-05-10 small fix
% Ver.1.2 2005-05-16 small fix
% Ver.2.0 2006-02-13 version up
% Ver.2.1 2006-06-07 first release of Ver.2
% Ver.2.2 2006-07-27 modify main.m to generate track seeking and
%                      following model
%
% Ver.3.0 2006-12-05 Initial Version as HDDbench.m
% Ver.3.1 2007-08-31 support for Ver.1 and Ver.2 parameter files

% clear all variables
clear

% Read Parameter files and Define hard disk model
param_ver = input(['Specify the version of parameter file [1 or 2]' ...
		   ' or just hit return: ']);
if isempty(param_ver)
    %error('Unsupported parameter version');
    if exist('hdd_plantparam','file')
	hdd_plantparam_file = 'hdd_plantparam';
    else
	hdd_plantparam_file = 'hdd_plantparam_v2';
    end
    if exist('hdd_distparam','file')
	hdd_distparam_file  = 'hdd_distparam';
    else
	hdd_distparam_file  = 'hdd_distparam_v2';
    end
else
    hdd_plantparam_file = sprintf('hdd_plantparam_v%d',param_ver);
    hdd_distparam_file  = sprintf('hdd_distparam_v%d',param_ver);
end

if ~exist(hdd_plantparam_file,'file')
    error(sprintf('Parameter file ''%s'' not found.\n',hdd_plantparam_file));
end
if ~exist(hdd_distparam_file,'file')
    error(sprintf('Parameter file ''%s'' not found.\n',hdd_distparam_file));
end

% Set plant models
options_f.seekmode = 0;	% 0 for track-following, 1 for track-seeking
options_s.seekmode = 1;	% 0 for track-following, 1 for track-seeking
PlantData     = SetPlantModel(hdd_plantparam_file,options_f);
PlantDataSeek = SetPlantModel(hdd_plantparam_file,options_s);

disp([PlantData.ModelName ' ' PlantData.Comment]);

% Set disturbance parameters
DistParam = SetDistParam(PlantData,hdd_distparam_file);

% Disturbances
ForceDist   = SetForceDist(PlantData,DistParam);
FlutterDist = SetFlutterDist(PlantData,DistParam);
SensorNoise = SetSensorNoise(PlantData,DistParam);
RRO         = SetRRO(PlantData,DistParam);

% save data
if isempty(param_ver)
    save mainPlantData PlantData PlantDataSeek
    save mainDistData  DistParam ForceDist FlutterDist SensorNoise RRO
    disp('mainPlantData and mainDistData were created')
else
    save(sprintf('mainPlantDataV%d',param_ver),...
	 'PlantData','PlantDataSeek');
    save(sprintf('mainDistDataV%d',param_ver),...
	 'DistParam','ForceDist','FlutterDist','SensorNoise','RRO');
    sprintf('mainPlantDataV%d and mainDistDataV%d were created',param_ver,param_ver);
end

% Plot plant and disturbance models
HDDBenchPlot

%% EOF of HDDBench.m
