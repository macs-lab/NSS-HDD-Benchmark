% PESEval.m  script for PES evaluation
%
%   Plot:
%   1. time domain plot (RPE/NRPE/TPE)
%   2. spectrum
%   3. histogram
%
%   Copyright (C) 2005, MSS benchmark working group
%   Ver.1.0, 2005-08-16 T. Hara


idxt=find(PESDataT.time >= 0.001);	% 10ms以降
PES = PESDataT.signals.values(idxt)*1e2;	% [%TP]
num_servo = PlantData.num_servo;

% 時間軸プロット
[RPE,NRPE,Val] = PES_PlotTD(PES,num_servo,'%TP');
figsize(500,320,'keep');


if ~exist('NFFT')
    NFFT = 16384;
end

% 周波数軸プロット
[psp,num] = PES_FFT(NRPE, NFFT, 1/Ts, 'psd');
figure;
PES_FFT(PES, NFFT, 1/Ts, 'psd', 'r');
hold on
plot(psp(:,1),psp(:,2));
figsize(960,320,'keep');
dF = psp(2,1);	% 周波数分解能
% スペクトラムから計算したNRPE6σ値
NRPE6s_spc = 6*sqrt(sum(10.^((psp(:,2)/10)))*dF);
title(sprintf('NRPE6\\sigma=%.2f (%%TP), NFFT=%d, \\DeltaF=%fHz, Number of Average=%d',...
	      NRPE6s_spc, NFFT, dF, num))


fprintf('')
% 時間軸から計算したNRPE6σ値
fprintf('NRPE6σ: %f (%%TP) calc from time history\n', 6*std(NRPE));
% スペクトラムから計算したNRPE6σ値
fprintf('NRPE6σspc: %f (%%TP) calc from spectrum\n', NRPE6s_spc);
% 各サーボセクタ毎に計算した6σのrms値
fprintf('NRPE6σrms: %f (%%TP) rms of each sector\n', Val.NRPE6sigma);

fprintf('RPEpp: %f, TPEpp: %f (%%TP)\n', Val.RPEpp, Val.TPEpp);

% ヒストグラム
x=[-20:0.5:20];
[hs1,xs1]=hist(NRPE,x);
[hs2,xs2]=hist(PES,x);

figure;
%plot(xs1,hs1,xs2,hs2)
plot(hs1,xs1,hs2,xs2)
figsize(460,320,'keep');
legend(sprintf('NRPE (3\\sigma=%.2f)',3*std(NRPE)),...
       sprintf('PES (3\\sigma=%.2f)',3*std(PES)))
xlabel('number of times')
ylabel('Displacement (%TP)')
grid on
title(sprintf('PES Histogram (N=%d)', size(PES,1)))
