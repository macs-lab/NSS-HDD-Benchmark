%PES_PlotTD  PESの時間軸プロット
%
%   PES_PlotTD(PES,num_servo,unit) はPES時刻歴データから回転同期成分(RPE)/回
%   転非同期成分(NRPE)/全成分(TPE)をプロットします
%
%   PES       : PES時刻歴データ
%   num_servo : 一周あたりのサーボセクタ数
%   unit      : (オプション) 単位をあらわす文字列 例:'%TP'
%
%   線の色：
%   赤：RPE
%   緑：TPEmax/min
%   青：NRPEmax/min
%   紫：NRPE6σ
%
%   Copyright (c) 2005, MSS benchmark working group
%   Ver.1.0, 2005-08-16 T. Hara
