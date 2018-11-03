%% zero the world
clear,clc
%% Exp 01
%% parameter
ramp = [30 30]; % in ms
% key parameter
fs = 44100; % in hz/s
amp = 1;
% parameters of linear up/down-sweep
freq1 = 200;
freq2 = 1000;
% length of a sweep in one direction
endTime = 0.5;
%% gen original sin tone
outputFile{1} = [pwd filesep 'ramp_sin_increase.wav'];
outputFile{2} = [pwd filesep 'ramp_sin_decrease.wav'];
pitchSND('sin',freq1,freq2,endTime,fs,amp,ramp,outputFile);
%% check generated sin tone
analyzeSnd('ramp_sin_increase.wav',freq1-200,freq2+200);
analyzeSnd('ramp_sin_decrease.wav',freq1-200,freq2+200);

%% Exp 2
%% clean the world
restoredefaultpath
clear,clc
%% import snd stim from exp 1
inputSND_increase = audioread('ramp_sin_increase.wav');
inputSND_decrease = audioread('ramp_sin_decrease.wav');

%% put gap1 middle
fs = 44100; % in hz/s
gapTime = 250/(1000/fs); % in ms
gapFade = [30/(1000/fs),30/(1000/fs)];
gapLength = ceil([40/(1000/fs)-2]);
if mod(gapLength,2)~=0
    gapLength=gapLength+1;
end
outputSND_increase = linearRamp_gap(inputSND_increase,gapTime,gapFade,gapLength);
outputSND_decrease = linearRamp_gap(inputSND_decrease,gapTime,gapFade,gapLength);

audiowrite('ramp_sin_increase_gap1.wav',outputSND_increase,fs);
audiowrite('ramp_sin_decrease_gap1.wav',outputSND_decrease,fs);

% parameters of linear up/down-sweep
freq1 = 200;
freq2 = 1000;
analyzeSnd('ramp_sin_increase_gap1.wav',freq1-200,freq2+200);
analyzeSnd('ramp_sin_decrease_gap1.wav',freq1-200,freq2+200);

%% put gap2: 375 ms
gapTime = 375/(1000/fs); % in ms
if mod(gapLength,2)~=0
    gapLength=gapLength+1;
end
outputSND_increase = linearRamp_gap(inputSND_increase,gapTime,gapFade,gapLength);
outputSND_decrease = linearRamp_gap(inputSND_decrease,gapTime,gapFade,gapLength);

audiowrite('ramp_sin_increase_gap2.wav',outputSND_increase,fs);
audiowrite('ramp_sin_decrease_gap2.wav',outputSND_decrease,fs);

% parameters of linear up/down-sweep
freq1 = 200;
freq2 = 1000;
analyzeSnd('ramp_sin_increase_gap2.wav',freq1-200,freq2+200);
analyzeSnd('ramp_sin_decrease_gap2.wav',freq1-200,freq2+200);

%% put gap3 right: 125 ms
gapTime = 125/(1000/fs); % in ms
if mod(gapLength,2)~=0
    gapLength=gapLength+1;
end
outputSND_increase = linearRamp_gap(inputSND_increase,gapTime,gapFade,gapLength);
outputSND_decrease = linearRamp_gap(inputSND_decrease,gapTime,gapFade,gapLength);

audiowrite('ramp_sin_increase_gap3.wav',outputSND_increase,fs);
audiowrite('ramp_sin_decrease_gap3.wav',outputSND_decrease,fs);

% parameters of linear up/down-sweep
freq1 = 200;
freq2 = 1000;
analyzeSnd('ramp_sin_increase_gap3.wav',freq1-200,freq2+200);
analyzeSnd('ramp_sin_decrease_gap3.wav',freq1-200,freq2+200);