% Gen Grating: wide
clear all
close all
[x,y]=meshgrid(1:500,1:500);
ang=0;
p=100;
phase=pi/2;
c=1;
gra=(sin((sind(ang)*x+cosd(ang)*y)*2*pi/p+phase)*c+1)/2;
imshow(gra)
imwrite(gra,'wideGrating_100.bmp');
close all
% Gen Grating: slight
clear all
close all
[x,y]=meshgrid(1:500,1:500);
ang=0;
p=75;
phase=pi/2;
c=1;
gra=(sin((sind(ang)*x+cosd(ang)*y)*2*pi/p+phase)*c+1)/2;
imshow(gra)
imwrite(gra,'slightGrating_75.bmp');
close all