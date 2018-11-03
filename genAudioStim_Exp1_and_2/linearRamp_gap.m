function outsig = linearRamp_gap (insig,gapPoint,gapFade,gapLength)
gapPoint = ceil(gapPoint);
% ramp signal according to the given time
L=length(insig);
L_before=gapFade(1);
L_after=gapFade(2);

gw_down=linspace(1,0,L_after+1).';

temp=linspace(1,0,L_before+1).';
gw_up=[flipud(temp(2:end-1))];

ramp=[ones(1,gapPoint-gapLength/2-L_before),gw_down',zeros(1,gapLength),gw_up',ones(1,(L-gapPoint)-gapLength/2-L_after)];
outsig=insig.*ramp.';