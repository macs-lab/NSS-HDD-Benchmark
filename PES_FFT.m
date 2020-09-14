function [data,num]=PES_FFT(PES, NFFT, Fs, option, ltype)
%PES_FFT  FFT of Position Error Signal
%
%   PESFFT(PES, NFFT, Fs, option, ltype) plots the power spectrum of PES
%   in the current figure window.
%
%   Using Hanning window, 50% overlapping
%
%   PES    : PES time history data
%   NFFT   : length of FFT
%   Fs     : sampling frequency
%   option : ''    plot as power (default)
%            'psd' plot as power spectrum density
%   ltype  : line type (default 'b')
%
%   [data,num] = PESFFT(PES, NFFT, Fs, option);
%   returns data = [f psp] and number of averaging.
%
%   Copyright (C) 2005, MSS benchmark working group
%   Ver.1.0, 2005-08-16 T. Hara

error(nargchk(3,5,nargin))

if ~exist('option') | isempty(option)
    option='';
end
if ~exist('ltype') | isempty(ltype)
    ltype='b';
end

num=floor(size(PES,1)/NFFT)*2-1;	% 50% Overlapping
SP=zeros(NFFT,num);

dF = Fs/NFFT;	% Freq. Resolution
frq = dF*[0:NFFT/2];

% Hanning Window, 50% Overlapping
han = hanning(NFFT);
for ii=1:num
    SP(:,ii) = fft(han .* PES(1+NFFT/2*(ii-1):NFFT/2*(ii+1)));
end
SP = abs(SP(1:NFFT/2+1,:)/(NFFT/2)).^2/2;	% /sqrt(2) Amp -> RMS

if strcmp(option,'psd') == 1
    SPdBmean = 10*log10(mean(SP,2)/dF/(3/8));	% /sqrt(dF)/sqrt(3/8)
else
    SPdBmean = 10*log10(mean(SP,2)*4);	% x2 to match with FFT analyzer
end

if nargout ~= 0
    data=[frq' SPdBmean];
else
    figure(gcf);
    plot(frq, SPdBmean, ltype)
    if strcmp(option,'psd') == 1
	% psd
	ylabel('PSD (dBrms/rtHz)');
    else
	% dBrms
	ylabel(['Power (dBrms \DeltaF=' num2str(dF) 'Hz)']);
    end
    grid on
    title(sprintf('Number of Average = %d', num));
    xlabel('Frequency (Hz)');
    ax = axis;
    axis([min(frq) max(frq) ax(3) ax(4)])
end
