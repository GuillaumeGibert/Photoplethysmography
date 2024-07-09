function [r, g, b] = spatialAverage(rawImg, x, y, width, height)
%%%%%%%%%%%%%%%%%%%%%%%%%
% function [r, g, b] = spatialAverage(rawImg, x, y, width, height)
% ex.: [r, g, b] = spatialAverage(rawImg, x, y, width, height)
%
% Task: To compute the spatial average of the red, blue and green channel over the ROI corrsponding to the subject's face
% 
% Inputs:
%	-rawImg: a matrix containing the raw image
%	-x: position of the top left corner of the ROI on the x-axis (in pixels)
%	-y: position of the top left corner of the ROI on the y-axis (in pixels)
%	-width: width of the ROI (in pixels)
%	-height: height of the ROI (in pixels)
%
% Outputs:
%	-r: average value of the red channel over the ROI of the subject's face
%	-g: average value of the green channel over the ROI of the subject's face
%	-b: average value of the blue channel over the ROI of the subject's face
%
%
% author: Guillaume Gibert, guillaume.gibert@ecam.fr
% date: 05/02/2024
%%%%%%%%%%%%%%%%%%%%%%%%%

% crop the current image around the face
faceImg = rawImg(y:y+height,x:x+width, :);

% displays the image of the face
%image(faceImg);

% spatial average for r, g, b channels
r = mean(mean(faceImg(:,:,1)));
g = mean(mean(faceImg(:,:,2)));
b = mean(mean(faceImg(:,:,3)));