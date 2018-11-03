function outsig = linearRamp (insig,ramplen)
% ramp signal according to the given time
L=length(insig);
L1=ramplen(1);  % rise time
L2=ramplen(2);  % fall time

gw_up=linspace(1,0,L1+1).';
win_up=[gw_up;flipud(gw_up(2:end-1))];
r1=win_up(L1+1:2*L1);

gw_down=linspace(1,0,L2+1).';
win_down=[gw_down;flipud(gw_down(2:end-1))];
r2=win_down(1:L2);

ramp=[r1;ones(L-L1-L2,1);r2];
outsig=insig.*ramp.';