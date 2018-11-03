function [amp, Fs] = analyzeSnd(file, freqbott, frequp)
% Matlab function analyze(file)
% plots the waveform and power spectrum of a wav sound file.
% For example, type analyze('piano.wav') at the Matlab prompt.
%
% Mark R. Petersen, U. of Colorado Boulder Applied Math Dept, Feb 2004


%[y, Fs] = wavread(file);      % y is sound data, Fs is sample frequency.
[y, Fs] = audioread(file);
if length(size(y))>1
    temp = y(:,1);
    clear y
    y = temp;
end
amp = max(abs(y));
t = (1:length(y))/Fs;         % time
% sound(y,Fs)

filename_old = file(1:end-4);
filename_new = strrep(file(1:end-4),'_',' ');
%ind = find(t>0.1 & t<0.12);   % set time duration for waveform plot
% ind = [1:length(t)];
h=figure;
subplot(4,2,1:2)
plot(t(1:ceil(length(t)*1)),y(1:ceil(length(t)*1)))
ylim([-1 1])
xlim([0 t(ceil(length(t)*1))])
% axis tight
title(['Overview Waveform of ' filename_new])

subplot(4,2,3)
plot(t(1:ceil(length(t)*0.1)),y(1:ceil(length(t)*0.1)))
ylim([-1 1])
xlim([0 t(ceil(length(t)*0.1))])
% axis tight
title(['Head 10% Waveform of ' filename_new])

subplot(4,2,4)
plot(t(ceil(length(t)*0.9):end),y(ceil(length(t)*0.9):end))
ylim([-1 1])
xlim([t(ceil(length(t)*0.9)),t(end)])
% axis tight
title(['Tail 10% Waveform of ' filename_new])

N = length(y);                     % number of points to analyze
c = fft(y(1:N))/N;            % compute fft of sound data
p = 2*abs(c(2:floor(N/2)));         % compute power at each frequency
f = (1:N/2-1)*Fs/N;           % frequency corresponding to p

subplot(4,2,5)
semilogy(f,p)
axis([freqbott frequp 10^-4 1])
title(['Power Spectrum of ' filename_new])

subplot(4,2,6)
z = hilbert(y);
f = angle(z(2:end).*conj(z(1:end-1))).*(Fs / (2*pi));
plot(t([1:length(f)]), f([1:length(f)]))
axis([0 max(t) freqbott frequp])
title(['Frequece Change of ' filename_new])

if verLessThan('matlab','9')
    disp('Pspectrum Not Support!!! R2016b Needed');
else
    subplot(4,2,7:8)
    pspectrum(y(:,1),Fs,'spectrogram', ...
        'FrequencyLimits',[freqbott frequp], ...
        'TimeResolution',max(t)/50,'Overlap',86,'Leakage',0.875)
end

%% export
print([filename_old],'-dtiff','-r600');

%% close figure
close(h)