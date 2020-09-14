function [w_org,h_org]=figsize(width, height, option)
%FIGSIZE  Change figure size
%
%   FIGSIZE(WIDTH,HEIGHT) changes the width and height of current figure.
%
%   [W_ORG,H_ORG] = FIGSIZE(WIDTH,HEIGHT) changes the width and height,
%   and returns the original width and height.
%
%   FIGSIZE(WIDTH,HEIGHT,'keep') changes the width and height of current
%   figure, keeping margins (subplots are not supported so far).
%
%   [W_ORG,H_ORG] = FIGSIZE returns the width and height of the figure.
%
%   Copyright (C) 2005, MSS benchmark working group
%   Ver.1.0, 2005-08-16 T. Hara

error(nargchk(0,3,nargin));

if ~exist('option')
    option = '';
end

pos = get(gcf, 'Position');

if nargin >= 2
    if strcmp(option,'keep')
	pos2 = get(gca, 'Position');
	
	% margin
	pos3 = [pos2(1) * pos(3)/width,...
		pos2(2) * pos(4)/height,...
		(1-pos2(3)) * pos(3)/width,...
		(1-pos2(4)) * pos(4)/height];
    end

    scr = get(0,'ScreenSize');	% [x0,y0,w,h]
    x0 = pos(1)+pos(3)/2-width/2;
    y0 = pos(2)+pos(4)/2-height/2;

    % '70' is for window bar and menu bars
    if (y0 + height + 70 > scr(4))
	y0 = scr(4) - height - 70;
    end

    set(gcf, 'Position', [x0, y0, width, height]);
    if strcmp(option,'keep')
	set(gca, 'Position', [pos3(1) pos3(2) 1-pos3(3) 1-pos3(4)]);
    end
    set(gcf, 'PaperPositionMode','Auto');
end

if nargout ~= 0
    w_org = pos(3);
    h_org = pos(4);
end
