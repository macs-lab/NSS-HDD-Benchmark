function [sys_plant, sys_p] = make_plant( Fn, Zeta, Gain )
%make_plant  make plant model
%
% [sys_plant, sys_p] = make_plant( Fn, Zeta, Gain )
% Input: 
%  Fn:         Center frequency of resonance [Hz]
%  Zeta:       damping factor
%  Gain:       Gain for each resonace
% Output:
%  sys_plant:  plant model in state-space form
%  sys_p:      each resonance models in state-space form
%  
% Copyright (c) 2004-2005, MSS benchmark working group
% Revistion 2.0

% H.Uchida Oct.28, 2004
% Modified by M.Hirata Apr.07, 2005
% Modified by M.Hirata July.13, 2007 for sys_p

%-------- check input  -------------------------------------
ni = nargin;
no = nargout;
error( nargchk(3, 3, ni) );

[mm,Num]=size(Fn);
Wn = 2*pi*Fn;
ap = [ 0 1;-Wn(1)^2, -2*Zeta(1)*Wn(1) ];
bp = [ 0; Gain(1) ];
cp = [ 1, 0 ];
sys_p(1,1,1) = ss(ap,bp,cp,0);
sys_plant  = sys_p(1);
for ii=2:Num
    ap = [ 0 1; -Wn(ii)^2, -2*Zeta(ii)*Wn(ii) ];
    bp = [ 0; Gain(ii) ];
    cp = [ 1, 0 ];
    sys_p(1,1,ii) = ss(ap,bp,cp,0);
    sys_plant = sys_plant + ss(ap,bp,cp,0);
end

%=<End of File>============================================================
