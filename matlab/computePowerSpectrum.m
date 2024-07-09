function [f, power] = computePowerSpectrum(signal, fs, hrFrequencyRange, plt)
%%%%%%%%%%%%%%%%%%
%function [f, power] = frequencySpectrum(signal, 60, [0.8 4], 1)
%
% Task: To compute and display the power spectrum of a given signal
%
% Input:
%	- signal: the input signal to process
%	- fs: the sampling rate
%	-hrFrequencyRange: frequency range of interest (in Hz) size 1x2
%	- plt: flag if >0 the power spectrum will be displayed
%
% Output: 
%	-f: frequency range array in Hz
% 	-power: power spectrum (normalized unit)
%	
%
% Guillaume Gibert, guillaume.gibert@ecam.fr
% 20/03/2021
%%%%%%%%%%%%%%%%%%

n = length(signal) ;         % number of samples
y = fft(signal, n);

f = (0:n-1)*(fs/n);     % frequency range
power = abs(y).^2/n;    % power of the DFT


if (plt)
	figure;
	indMin = floor(hrFrequencyRange(1) / fs * n);
	indMax = floor(hrFrequencyRange(2) / fs * n);
	plot(f(indMin:indMax),power(indMin:indMax))
	xlabel('Frequency (Hz)')
	ylabel('Power (a.u.)')
end

