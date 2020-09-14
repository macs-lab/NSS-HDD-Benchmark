function [Pxx,f] = psdcal(y,nfft,Ts);
%PSDCAL  Calculate Power Spectrum Density
%
%   Copyright (c) 2004-2005, MSS benchmark working group
%   Copyright (c) 2006-, HDD benchmark working group
%   Ver.1.0, 2006-02-14

% Author(s): M.Hirata
% Ver.1.0 2006-02-14

y_num = length(y);
if ( y_num < nfft )
    error('y is short than nfft')
end

if ( fix(nfft/2) ~= nfft/2 )
    nfft = nfft + 1;
end

k = fix(y_num/nfft)*2-1;
Pxx = zeros(nfft/2,1);
xindx = 1;
win = hanning(nfft);
% win = boxcar(nfft);
U = win'*win;
% nfft
for ii=1:k
    yin = y(xindx:xindx+nfft-1);
    yout0 = fft(yin.*win)./sqrt(U);
    yout  = abs(yout0(1:nfft/2)).^2*2*Ts; % •Ð‘¤‚Ì‚½‚ß2”{‚·‚é
    Pxx = Pxx + yout;
    xindx = xindx + nfft/2;
end
Pxx = Pxx ./ k;
f = (0:nfft/2-1)'/nfft*(1/Ts);

%% EOF of psdcal.m
