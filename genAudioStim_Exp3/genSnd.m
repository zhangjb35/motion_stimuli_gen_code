%% zero the world
clear, clc
%% generate pure tone
sampleRate = 44100; % in hz/s
freq = 900; % in hz
duration = 0.5; % in second
time = linspace(0,duration,sampleRate*duration);
%% no ramp and check
tone = sin(2*pi*freq*time);
audiowrite('origin_pitch.wav',tone,sampleRate)
% check
freqbott = 100; % in hz, set to show freqence infomation
frequp = 2000;
analyzeSnd('origin_pitch.wav',freqbott,frequp);
%% ramp sound and check
ramp_duration = 0.05; % in second
ramp_tone = linearRamp(tone,[ceil(ramp_duration*1000/(1000/sampleRate)), ceil(ramp_duration*1000/(1000/sampleRate))]);
audiowrite('ramp_pitch.wav',ramp_tone,sampleRate)
% check
freqbott = 100; % in hz, set to show freqence infomation
frequp = 2000;
analyzeSnd('ramp_pitch.wav',freqbott,frequp);
%% zero the world
%close all