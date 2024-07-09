function rgbNorm = normalizeSignals(rgb, avgRGB, stdRGB)
%%%%%%%%%%%%%%%%%%%%%%%%%
% function rgbNorm = normalizeSignals(rgb, avgRGB, stdRGB)
% ex.: rgbNorm = normalizeSignals(rgb, avgRGB, stdRGB)
%
% Task: To normalize the temporal variation of the red, blue and green channels 
% 
% Inputs:
%	-rgb: temporal variation of the (spatially-averaged) red, green and blue channels arrayof size Nx3
%	-avgRGB: average values of the red, green and blue channels over time (size 1x3)
%	-stdRGB: standard deviation values of the red, green and blue channels over time (size 1x3)
%
% Outputs:
%	-rgbNorm:  Normalized temporal variation of the (spatially-averaged) red, green and blue channels arrayof size Nx3
%
%
% Author: Guillaume Gibert, guillaume.gibert@ecam.fr
% Date: 05/02/2024
%%%%%%%%%%%%%%%%%%%%%%%%%

rgbNorm = (rgb-avgRGB) ./ stdRGB;