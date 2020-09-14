function [seektime,y_max] = evseek(y_all,Ts,rm_inf,fft_time,fig_num)
%EVSEEK  Evaluate seek performance
%   [seektime,y_max] = evseek(y_all,Ts,rm_inf,fft_time,fig_num)
%
%   Input argument
%   y_all    : time response of recording head
%   Ts       : sampling time of y_all
%   rm_inf   : target track
%   fft_time : time length for FFT analysis
%   fig_num  : start figure number
%
%   Copyright (c) 2006-, HDD benchmark working group
%   Ver.3.1, 2007-08-31

% Author(s): M.Hirata, T.Hara
% Ver.1.0 2006-08-29 by M.Hirata
% Ver.3.0 2006-12-05 by T.Hara
% Ver.3.1 2007-08-31 small fix

% option
if nargin == 4
    fig_num = 100;
elseif nargin < 4 | nargin > 5
    error('Invalid input argument')
end

% parameters
crt = 0.1; % ÉVÅ[ÉNîªíËäÓèÄ

% size
[nn,mm] = size(y_all);
ts = (0:nn-1)*Ts;

for ii=1:mm
    ys       = y_all(:,ii);
    yon      = (abs(ys-rm_inf) < crt);
    se(ii)   = max(find(yon==0));
    ymax(ii) = max(ys);
end
% Find maximum seeking-time
seek_on = max(se);
y_max   = max(ymax);
vv      = ones(nn,1);

% Plot head response
figure(fig_num);
plot(ts,y_all,...
    ts,vv*(rm_inf+crt),'r:',ts,vv*(rm_inf-crt),'r:',...
    [seek_on,seek_on]*Ts, [rm_inf-0.5,rm_inf+0.5],'r:')
axis([0 2e-3 rm_inf-0.5 rm_inf+0.5])
xlabel('Time [s]'), ylabel('Position [track]');
xlabel('Seek response around target track')

% Print seektime
seektime = seek_on*Ts;
str = sprintf('Seek time = %f ms\nMax(y) = %f track',seektime*1000,y_max);
% text((seek_on+50)*Ts,rm_inf-crt*2,str)
text((seek_on+10)*Ts,rm_inf-crt*2,str)

% Cal fft gain
fft_length = 2^14;
end_idx = seek_on + fix(fft_time/Ts);
% [seek_on,end_idx,nn] % for debug
for ii=1:mm
    ysrv = y_all(seek_on:end_idx,ii);
    llg  = length(ysrv);
    yss  = [ysrv-rm_inf; zeros(fft_length-llg,1)];
    [yspec,ff] = fftgain(yss,Ts);
    yspec_all(:,ii) = yspec;
    yss_all(:,ii) = yss;
end

figure(fig_num+1)
plot(ff,yspec_all);
set(gca,'XLim',[0 2e4])
xlabel('Frequency [Hz]'), ylabel('FFT Gain [Mag]')
title('FFT of residual vibration')

% for debug
% figure(102)
% plot(yss_all)

function [g_abs,f,g_comp] = fftgain(y,Ts);
% fftgain.m
% Calculate FFT gain
% M.Hirata
% Ver.1.0, 2005-04-26
% Ver.1.1, 2005-04-28, bug fix of output argument
% Copyright (c) 2004-2005, MSS benchmark working group

y_num = length(y);
N = fix(y_num/2);
f = (0:N-1)'/y_num*(1/Ts);
g_comp0 = fft(y);
g_comp  = g_comp0(1:N,:);
g_abs   = abs(g_comp);

%% EOF of fftgain.m
