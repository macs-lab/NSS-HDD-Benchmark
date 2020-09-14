% evperf.m  m-script for control performance evaluation
%
%   Copyright (c) 2004-2005, MSS benchmark working group
%   Copyright (c) 2006-, HDD benchmark working group
%   Ver.3.1, 2007-08-31

% Author(s): M.Hirata, H.Uchida, T.Hara
% Ver.1.0, 2005-05-10 M.Hirata
% Ver.2.0, 2005-08-30 M.Hirata, modified to use PES_PlotTD function
% Ver.2.1, 2005-08-30 H.Uchida
% Ver.3.0, 2006-12-05 T.Hara
% Ver.3.1, 2007-08-31 small fix

% Option for figure plot
close_figure = 1; % (1: close figure, 0: keep all figures)

% Loop gain perturbation
loopgain_pt = PlantData.DeltaKp;

% For robust switch
if (robust_sw==1)
    gnum         = length(loopgain_pt);
    [nn,mm,pnum] = size(PlantData.Pfpert);
elseif (robust_sw==2)
    gnum = 1;
    pnum = 1;
else
    gnum = length(loopgain_pt);
    pnum = 1;
end
% for debug
% if pnum > 3
%    pnum = 3;
% end
num_servo = PlantData.num_servo;

MVer = version;
if strcmp(MVer(1),'5')
    % MATLAB5.x is not fully supported. See document.
    SimModel = 'SimTrackFollowing5';
else
    SimModel = 'SimTrackFollowing';
end

% Sampling time for plant input
Tu = PlantData.Tu;

% Simulation Time
if ~exist('Tsim','var')
    Tsim = NmaxTs*Ts;
end

% Run simulation
close all
if ~exist('nosim')
    clear NRPE3sigma RPEpp Result; 

    idx = 1;
    for jj=1:gnum
        for ii=1:pnum
            loopgain = 1+loopgain_pt(jj);
            fprintf('Model No.%d, loopgain = %4.2f : ',ii,loopgain);
            sys_P = PlantData.Pfpert(1,1,ii);
            sysd_P = c2d(ssbal(sys_P),Tu); % discretize with input delay (Tc -> Tu, Ver.3.1)
            tic;
            sim(SimModel,Tsim);
            etime = toc;
            idxt = find(PESDataT.time >= 10e-3);        % 10msˆÈ~
            PES  = PESDataT.signals.values(idxt)*1e2;	% [%TP]
            % ŽžŠÔŽ²ƒvƒƒbƒg
            if close_figure, close, end
            [rpe,nrpe,val] = PES_PlotTD(PES,num_servo,'%TP');
            drawnow
%             figsize(500,320,'keep'); % comment out (Ver.3.1)
            val_nrpe3sigma = val.NRPE6sigma/2;
            val_rpepp      = val.RPEpp;
            fprintf('NRPE 3sigma = %f, RPEpp = %f',val_nrpe3sigma,val_rpepp);
            fprintf(' (elapsed time = %g (s))', etime);
            fprintf('\n')
            Result(idx,:)   = [ii,loopgain,val_nrpe3sigma,val_rpepp]; 
            NRPE3sigma(idx) = val_nrpe3sigma;
            RPEpp(idx)      = val_rpepp;
            idx = idx + 1;
        end
    end
end

if gnum*pnum > 1
    % Plot summary
    NRPE3sigma2 = reshape(NRPE3sigma,pnum,gnum);
    RPEpp2      = reshape(RPEpp,pnum,gnum);
    idxp        = 1:pnum;

    % NRPE3sigma
    figure;
    plot(idxp,NRPE3sigma2(:,1),'r*-',...
	 idxp,NRPE3sigma2(:,2),'go-',...
	 idxp,NRPE3sigma2(:,3),'bs-')
    set(gca, 'XTick', [1:pnum])
    set(gca, 'YLim', [7 10])
    xlabel('Model number'), ylabel('NRPE 3sigma [percent/track]')
    legend('Nominal loopgain','loopgain = +10%','loopgain = -10%')
    title('None Repeatable Position Error (NRPE)')

    % RPEpp
    figure;
    plot(idxp,RPEpp2(:,1),'r*-',...
	 idxp,RPEpp2(:,2),'go-',...
	 idxp,RPEpp2(:,3),'bs-')
    set(gca, 'XTick', [1:pnum])
    set(gca, 'YLim', [10 14])
    xlabel('Model number'), ylabel('RPEpp [percent/track]')
    legend('Nominal loopgain','loopgain = +10%','loopgain = -10%')
    title('Repeatable Position Error Peak-to-Peak (RPEpp)')
end

% Transfer 'Result' into Excel-file 
%data2ex(Result, strDesignMethod, strDesigner, Excel_filename); 

%% EOF of evperf.m
