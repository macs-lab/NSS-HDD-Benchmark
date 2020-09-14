% HDDBenchPlot.m  m-script for plotting plant and disturbance models
%
%   Copyright (c) 2004-2005, MSS benchmark working group
%   Copyright (c) 2006-, HDD benchmark working group
%   Ver.3.0, 2006-12-05

% Derived from main.m
% Author(s): M.Hirata, T.Hara
% Ver.1.0 2005-04-26
% Ver.1.1 2005-05-10 small fix
% Ver.1.2 2005-05-16 small fix
% Ver.2.0 2006-02-13 version up
% Ver.2.1 2006-06-07 first release of Ver.2
% Ver.2.2 2006-07-27 modify main.m to generate track seeking and
%                    following model
%
% Ver.3.0 2006-12-05 Initial Version as HDDbench.m

% Plot frequency response of plant model
plotseekmodel = 0;
if ~plotseekmodel
    Pn     = PlantData.Pn;     % nominal model
    Pf     = PlantData.Pf;     % full-order model
    Pfpert = PlantData.Pfpert; % full-order model with parametric uncertainty
else
    Pn     = PlantDataSeek.Pn;     % nominal model
    Pf     = PlantDataSeek.Pf;     % full-order model
    Pfpert = PlantDataSeek.Pfpert; % full-order model with parametric uncertainty
end    

f = logspace(1,5,2000);
figure(1)
plot_bode(Pn,f,1,1);
title('Nominal model')

figure(2)
plot_bode(Pf,f,2,1);
title('Full-order model')

figure(3)
plot_bode(Pfpert,f,3,1);
title('Full-order model w/ parametric variation')


% Disturbance and Noise in freqency domain
f        = DistParam.Freqs;
NRROSpec = sqrt(ForceDist.SpecAtPes.^2 + FlutterDist.Spec.^2 + SensorNoise.Spec.^2);
SpecALL  = sqrt(NRROSpec.^2 + RRO.Spec.^2);

figure(4)
semilogx(f,20*log10([ForceDist.SpecAtPes,FlutterDist.Spec,SensorNoise.Spec,RRO.Spec+eps,SpecALL]));
title('Dist data in frequency domain')
xlabel('Frequency [Hz]'), ylabel('Magnitude [dB]')
axis([1e1 1e4 -120 0])
legend('Force Dist at PES','Flutter Dist','Sensor Noise','RRO','ALL')

% Disturbance and Noise in time domain
% Force Dist
tTD    = ForceDist.Time;
yTD    = ForceDist.Data;
tTDpes = ForceDist.TimeAtPes;
yTDpes = ForceDist.DataAtPes;
% Sensor Noise
tSN = SensorNoise.Time;
ySN = SensorNoise.Data;
% Flutter Dist
tFD    = FlutterDist.Time;
yFD    = FlutterDist.Data;
tFDpes = FlutterDist.TimeAtPes;
yFDpes = FlutterDist.DataAtPes;
% RRO Dist
tRD = RRO.Time;
yRD = RRO.Data;

figure(5)
subplot(411)
plot(tTDpes,yTDpes);
title('Force Dist at PES')
%xlabel('Time [s]'), 
ylabel('PES [track]')
%
subplot(412)
plot(tSN,ySN);
title('Sensor Noise')
%xlabel('Time [s]'), 
ylabel('PES [track]')
%
subplot(413)
plot(tFD,yFD);
title('Flutter Dist')
%xlabel('Time [s]'), 
ylabel('PES [track]')
%
subplot(414)
plot(tRD,yRD);
title('RRO')
xlabel('Time [s]'), ylabel('PES [track]')
subplot(111)

yALL = yTDpes + ySN + yFDpes + yRD;
figure(6)
plot(tTDpes,yALL)
title('ALL Dist at PES')
xlabel('Time [s]'),ylabel('PES [track]')

% Relation between time domain and frequency domain
Ts   = PlantData.Ts;
Nfft = 2^12; % fft length
Nfft = 26400;

% Calc PSD
[g_all,ff] = psdcal(yALL,Nfft,Ts);
% [g_all,ff] = psdcal(yFDpes,Nfft,Ts);

figure(7)
semilogx(ff,20*log10(g_all)/2,f,20*log10(SpecALL),'r');
axis([1e1 1e4 -80 -20])
xlabel('Frequecy [Hz]'), ylabel('sqrt(PSD)')
legend('PSD of dist sequence','Dist data in freq. domain')

