%PES_FFT  Position Error SignalのFFTプロット
%
%   PESFFT(PES, NFFT, Fs, option, ltype) はPESのパワースペクトラムをカレ
%   ントフィギュア上にプロットします。
%
%   ハニング窓関数を使用，オーバーラップ50%
%
%   PES    : PES時刻歴データ
%   NFFT   : FFT長さ
%   Fs     : サンプリング周波数
%   option : ''    パワースペクトラム (default)
%            'psd' パワースペクトラム密度としてプロット
%   ltype  : 線の形式 (default 'b')
%
%   [data,num] = PESFFT(PES, NFFT, Fs, option);
%   は data = [f psp] および平均化回数 num を返します。
%
%   Copyright (C) 2005, MSS benchmark working group
%   Ver.1.0, 2005-08-16 T. Hara
