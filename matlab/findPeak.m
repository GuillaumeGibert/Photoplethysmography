function hrBPM = findPeak(f, powerSpectrum, hrFrequencyRange )
%%%%%%%%%%%%%%%%%%
%function hrBPM = findPeak(f, powerSpectrum, [0.8 4])
%
% Task: To determine the peak of the power spectrum in a given frequency range
%
% Input:
%	-f: frequency range array in Hz
%	-powerSpectrum: power spectrum (normalized unit)
%	-hrFrequencyRange: frequency range of interest (in Hz) size 1x2
%
% Output: 
%	-hrBPM: heart rate in beats per minute
%	
%
% Guillaume Gibert, guillaume.gibert@ecam.fr
% 05/02/2024
%%%%%%%%%%%%%%%%%%


[maxValue, indMaxValue] = max(powerSpectrum(f > hrFrequencyRange(1) & f < hrFrequencyRange(2)));

indexMinFreqRange = find(f > hrFrequencyRange(1));

hrBPM = f(indexMinFreqRange(1) + indMaxValue) * 60;
