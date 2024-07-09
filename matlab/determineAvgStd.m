function [avgRGB, stdRGB] = determineAvgStd(rgb)
%%%%%%%%%%%%%%%%%%%%%%%%%
% function [avgRGB, stdRGB] = determineAvgStd(rgb)
% ex.: [avgRGB, stdRGB] = determineAvgStd(rgb)
%
% Task: To compute the temporal average and standard deviation of the red, blue and green channels 
% 
% Inputs:
%	-rgb: temporal variation of the (spatially-averaged) red, green and blue channels arrayof size Nx3
%
% Outputs:
%	-avgRGB: average values of the red, green and blue channels over time
%	-stdRGB: standard deviation values of the red, green and blue channels over time
%
%
% Author: Guillaume Gibert, guillaume.gibert@ecam.fr
% Date: 05/02/2024
%%%%%%%%%%%%%%%%%%%%%%%%%

avgRGB = mean(rgb);
stdRGB = std(rgb);