function plot_bode( sys_siso, freq, fig_num, fig_clear, line_color_num, max_line_color, fig_line_width )
%plot_bode  plot a bode diagram of SISO system
%
% plot_bode( sys_siso, freq, fig_num, fig_clear, fig_color_num, max_line_color )
% Input: 
%  sys_siso:
%  freq:           frequency array [ mm x 1 ]
%  fig_num:        figure number  
%  fig_clear:      switch for clear old figure before plot new figure
%  line_color_num:  data line's color
%  max_line_color:  max_line_color
%  fig_line_width:  line width 0.5, 1, 2,...
% Output:
%  NA
%  
% Copyright (c) 2004-2006, MSS benchmark working group
% Revision 1.3
% M.Hirata Mar.10, 2005

% H.Uchida Oct.29, 2004
% H.Uchida Nov.26, 2004
% M.Hirata Apr.07, 2005

%-------- check input  -------------------------------------
ni = nargin;
no = nargout;
error( nargchk(1, 7, ni) );

if(ni<2),
    freq=0;
end

if(ni<3),
    fig_num=1;
end
if(ni<4),
    fig_clear=1;
end
if(ni<5),
    line_color_num=1;
end
if(ni<6),
    max_line_color=8;
end
if(ni<7),
    fig_line_width=0.5;
end

if( max_line_color<1),
    max_line_color=8;
end
if( max_line_color>64),
    max_line_color=64;
end

if(fig_line_width<0.5),
    fig_line_width=0.5;
end

figure(fig_num);
if(fig_clear) clf; end
% set(gcf,'Color','w');

[Mnum,Nnum,MMnum] = size(sys_siso);
[freq_l] = length(freq);
for mm=1:MMnum
    if (( ni == 1 | freq_l == 1 ) & mm == 1)
        [mag,ph,w]=bode(sys_siso(1,1,mm));
    else
        [mag,ph,w]=bode(sys_siso(1,1,mm),freq*2*pi);
    end
    if mm == 1
        f = w/(2*pi);
        FreqMin=10^fix(log10(min(f)));
        FreqMax=max(f);
        freq = f; % for next loop
    end
    ph=mod(ph+180,360)-180;
    magnitude = mag(1,1,:);
    magnitude = magnitude(:);
    phase     = ph(1,1,:);
    phase     = phase(:);
    fig_color = num2color(line_color_num, max([MMnum,max_line_color]));
    subplot(211);
     semilogx(f,20*log10(abs(magnitude)),'Color',fig_color,'LineWidth',fig_line_width);
     grid on;
     hold on;
     ylabel('Gain (dB)');
     xlabel('Frequency (Hz)');
    subplot(212);
     semilogx(f,phase,'Color',fig_color,'LineWidth',fig_line_width);
     grid on;
     hold on;
     ylabel('Phase (degree)');
     xlabel('Frequency (Hz)');
     line_color_num=line_color_num+1;
end

figure(fig_num);
subplot(211);
    grid on;
    ylabel('Gain (dB)');
    xlabel('Frequency (Hz)');
    set( gca, 'xlim',  [FreqMin FreqMax]); 
subplot(212);
    grid on;
    ylabel('Phase (degree)');
    xlabel('Frequency (Hz)');
    set( gca, 'ytick', [-180 -90  0 90 180] );
    set( gca, 'ylim',  [-180 180]); 
    set( gca, 'xlim',  [FreqMin FreqMax]);
subplot(211)

function  RGBColor = num2color( num_c, num_max )
% num2color: Number to RGB conversion
%  
% H.Uchida Oct.28, 2004
% Revistion 1.0
% Copyright (c) 2004 by MSS benchmark working group
%
% RGBColor = num2color( num_c, num_max )
% Input: 
%  num_c:   the number of color
%   From 1 to num_max, color is gradually changed
%  num_max: the maximum number of color 
% Output:
%  RGBColor: [Red, Green, Blue]
% 

cmap=[   0         0    0.5625
         0         0    0.6250
         0         0    0.6875
         0         0    0.7500
         0         0    0.8125
         0         0    0.8750
         0         0    0.9375
         0         0    1.0000
         0    0.0625    1.0000
         0    0.1250    1.0000
         0    0.1875    1.0000
         0    0.2500    1.0000
         0    0.3125    1.0000
         0    0.3750    1.0000
         0    0.4375    1.0000
         0    0.5000    1.0000
         0    0.5625    1.0000
         0    0.6250    1.0000
         0    0.6875    1.0000
         0    0.7500    1.0000
         0    0.8125    1.0000
         0    0.8750    1.0000
         0    0.9375    1.0000
         0    1.0000    1.0000
    0.0625    1.0000    1.0000
    0.1250    1.0000    0.9375
    0.1875    1.0000    0.8750
    0.2500    1.0000    0.8125
    0.3125    1.0000    0.7500
    0.3750    1.0000    0.6875
    0.4375    1.0000    0.6250
    0.5000    1.0000    0.5625
    0.5625    1.0000    0.5000
    0.6250    1.0000    0.4375
    0.6875    1.0000    0.3750
    0.7500    1.0000    0.3125
    0.8125    1.0000    0.2500
    0.8750    1.0000    0.1875
    0.9375    1.0000    0.1250
    1.0000    1.0000    0.0625
    1.0000    1.0000         0
    1.0000    0.9375         0
    1.0000    0.8750         0
    1.0000    0.8125         0
    1.0000    0.7500         0
    1.0000    0.6875         0
    1.0000    0.6250         0
    1.0000    0.5625         0
    1.0000    0.5000         0
    1.0000    0.4375         0
    1.0000    0.3750         0
    1.0000    0.3125         0
    1.0000    0.2500         0
    1.0000    0.1875         0
    1.0000    0.1250         0
    1.0000    0.0625         0
    1.0000         0         0
    0.9375         0         0
    0.8750         0         0
    0.8125         0         0
    0.7500         0         0
    0.6875         0         0
    0.6250         0         0
    0.5625         0         0];

%-------- check input  -------------------------------------
ni = nargin;
no = nargout;
error( nargchk(1,2, ni) );

if(ni==1),
    num_max=16;
end
num_c   = num_c+1;
num_max = num_max+1;

if(num_max<1),
    num_max=1;
end    

num_c=mod(num_c-1,num_max)+1;
ii=max(min(64,round(num_c/num_max*64)),1);

RGBColor=cmap(ii,:);

%=<End of File>============================================================
