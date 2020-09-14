% followdemo.m  design example by PID + Notch filter
%
%   Copyright (c) 2004-2005, MSS benchmark working group
%   Copyright (c) 2006-, HDD benchmark working group
%   Ver.3.1, 2007-07-06

% Controller Designed by H.Uchida
% Author(s): M.Hirata, H.Uchida, T.Hara
% Ver.1.0 2005-05-10
% Ver.1.1 2005-05-15 parameters of notch filters are included in this m-script
% Ver.1.2 2005-05-16 controller gain is adjusted for new track pitch
% Ver.2.0 2005-08-30 modified to use new performance evaluation function
% Ver.2.1 2005-08-30 add variables for DesignMethod & DesignerName
% Ver.3.0 2006-12-05 
% Ver.3.1 2007-07-06 small fix

% load all data
load mainPlantDataV1;
load mainDistDataV1;

% DesignMethod & DesignerName
strDesignMethod='PID + Notch Filter';
strDesigner    ='H. Uchida';
Excel_filename =[pwd,'\eval_sheet.xls'];


Ts = PlantData.Ts;   % sampling time of PES
Tc = Ts/2; % sampling time of control input (Multi-rate Notch Filter)

% Notch filter design
a =[  1.606    -0.8177;  
      1         0     ];
b =[  0.935;         0];
c =[ -0.1059    0.1206];
d =  0.935;
sys_NF_4100=ss(a,b,c,d,Tc);

a =[  1.533    -0.8506;
      1         0     ];
b =[  0.9308;        0];
c =[ -0.1097    0.1333];
d =  0.9308;
sys_NF_5000=ss(a,b,c,d,Tc);

a =[  0.8627   -0.4936;
      1         0     ];
b =[  0.7434;        0];
c =[ -0.2204    0.4382];
d =  0.7434;
sys_NF_8200=ss(a,b,c,d,Tc);

a =[   0.2247  -0.4117;
       1        0    ];
b =[  0.6945;   0    ];
c =[  0.01887   0.5033];
d =  0.6945;
sys_NF_12300=ss(a,b,c,d,Tc);

% Series connection of notch filters
sys_NF = sys_NF_4100 * sys_NF_8200 * sys_NF_12300 * sys_NF_5000;

% PID controller
Freq_zc  = 1000;                 % Hz
coef_PID = [2,0.05,70];          % P,I,D gain
sys_C    = tf(coef_PID(1)*[1,-1,0]+coef_PID(2)*[0,1,0]+coef_PID(3)*[1,-2,1],...
	      [1, -1, 0], Ts);

% Gain adjustment
g_adjust = 1.665e3;
sys_C    = sys_C/g_adjust;

% Simulation
% Switch for robustness test
robust_sw = 3; % default
robust_sw = input(['0:Gain Perturbation Only\n'...
		   '1:Gain and Model Perturbation\n'...
		   '2:No Perturbation\n'...
           '3:Stop\n'...
		   '(0-3)? ']);
if (robust_sw == 3)
    break
end

% Run evperf
[NmaxTs,m] = size(SensorNoise.Data);
[NmaxTc,m] = size(ForceDist.Data);
sys_C1 = sys_C;
sys_C2 = sys_NF;
g_torque  = 1;
g_sensor  = 1;
g_flutter = 1;
g_rro     = 1;
%Tsim = 1;	% シミュレーション時間 [s]
		% ※ 簡易シミュレーションの場合は短くしても良い
% call evperf
evperf

%% EOF of followdemo.m
