function [genSND,FS] = pitchSND(sndType,freq1,freq2,endTime,fs,amp,ramp,outputFile)
% number of samples of a sweep in one sweep direction
N = endTime * fs;
if isequal(sndType,'sin')
    % instantaneous frequency at each point in time ...
    % ... first increasing for N points, then decreasing for N points
    inst_f = [linspace(freq1, freq2, N) linspace(freq2, freq1, N)];
    
    % since (in continuous time) instantaneous frequency is derivative of
    % phase, we have to compute the "integral" to get the phase for sin().
    phi = 2 * pi * cumsum(inst_f) / fs;
    
    genSND_AIO = sin(phi);
    
    freq1_to_freq2 = genSND_AIO(1:length(genSND_AIO)/2);
    freq2_to_freq1 = genSND_AIO(length(genSND_AIO)/2+1:end);
    freq1_to_freq2_amp = amp*(freq1_to_freq2/max(abs(freq1_to_freq2')));
    freq2_to_freq1_amp = amp*(freq2_to_freq1/max(abs(freq2_to_freq1')));
    freq1_to_freq2_amp_ramp = linearRamp(freq1_to_freq2_amp,[ceil(ramp(1)/(1000/fs)), ceil(ramp(2)/(1000/fs))]);
    freq2_to_freq1_amp_ramp = linearRamp(freq2_to_freq1_amp,[ceil(ramp(1)/(1000/fs)), ceil(ramp(2)/(1000/fs))]);
    audiowrite(outputFile{1},repmat(freq1_to_freq2_amp_ramp,2,1)',fs);
    audiowrite(outputFile{2},repmat(freq2_to_freq1_amp_ramp,2,1)',fs);
    %% sampling rate
    FS = fs;
    %%
    genSND = genSND_AIO;
elseif isequal(sndType,'tri')
    % instantaneous frequency at each point in time ...
    % ... first increasing for N points, then decreasing for N points
    inst_f = [linspace(freq1, freq2, N) linspace(freq2, freq1, N)];
    
    % since (in continuous time) instantaneous frequency is derivative of
    % phase, we have to compute the "integral" to get the phase for sin().
    phi = 2 * pi * cumsum(inst_f) / fs;
    
    genSND_AIO = sawtooth(phi,0.5);
    
    freq1_to_freq2 = genSND_AIO(1:length(genSND_AIO)/2);
    freq2_to_freq1 = genSND_AIO(length(genSND_AIO)/2+1:end);
    audiowrite(outputFile{1},freq1_to_freq2,fs);
    audiowrite(outputFile{2},freq2_to_freq1,fs);
    %% sampling rate
    FS = fs;
    %%
    genSND = genSND_AIO;
end
end
