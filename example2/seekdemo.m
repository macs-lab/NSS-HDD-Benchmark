% seekdemo.m  Track-seeking demo using Final-State Control for HDD benchmark
%
%   Copyright (C) 2006-, HDD benchmark working group
%   Ver.3.1, 2007-08-31

% Controller and Feedforward Input were Designed by M.Hirata
% Author(s): M.Hirata, T.Hara
% Ver.1.0 2006-08-29 by M.Hirata
% Ver.3.0 2006-12-05 by T.Hara
% Ver.3.1 2007-08-31 by M.Hirata

clear
load mainPlantDataV2

% シーク終了判定基準
crt = 0.1;     % track

% Extract variables
sys_Pn     = PlantDataSeek.Pn;
sys_Pf     = PlantDataSeek.Pf;
sys_Pfpert = PlantDataSeek.Pfpert;
Ts         = PlantDataSeek.Ts;

% load feeforward input data
inputid = input('Please select feedforward input [0-2] : ');
%
if inputid == 0
    load ffdata0; U = Une;  Y = Yne;
elseif inputid == 1
    load ffdata1; U = Uw1e; Y = Yw1e;
elseif inputid == 2
    load ffdata2; U = Uw2e; Y = Yw2e;
else
    error('Invarid number!')
end
Umax = max(abs(U));

% Feedforward入力のプロット
figure(1)
tr   = (0:N+Na)*Ts;
[x1,y1] = stairs(tr,U);
plot(x1,y1);
% set(gca,'XLim',[0 x1(end)])
set(gca,'XLim',[0 2e-3])
xlabel('Time [s]'), ylabel('Control input')

% Simulink Model
MVer = version;
if strcmp(MVer(1),'5')
    % MATLAB5.x is not fully supported. See document.
    SimModel = 'fscsim5';
else
    SimModel = 'fscsim';
end

% 出力応答の計算（フィードフォワード）
[nn,mm,pnum] = size(sys_Pfpert);
idx = 1;
for ii=1:pnum
    sys_P = sys_Pfpert(1,1,ii);
    %[apf,bpf,cpf,dpf] = ssdata(sys_P);
    sysd_P = c2d(ssbal(sys_P),Ts/10); % Discretize with fast sampling time
    sim(SimModel)
    % check seeking-time
    yon = (abs(ys-rm_inf) < crt);
    se(idx) = max(find(yon==0));
    y_all(:,idx) = ys;
    idx = idx + 1;
end
% Find maximum seeking-time
seek_on = max(se);
vv = ones((N+Na)*10+1,1);

% Evaluate seek performance
[seektime,y_max] = evseek(y_all,Ts/10,rm_inf,10e-3,2);
% Input argument
% y_all:  time response of recording head
% Ts/10:  sampling time of y_all
% rm_inf: target track
% 10e-3:  time length for FFT analysis
% 2:      start figure number

%% EOF of seekdemo.m
