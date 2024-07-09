function [x, y, width, height] = faceDetection(rawImg)
%function [x, y, width, height] = faceDetection(rawImg)
%%%%%%%%%%%%%%%%%%%%%%%%%
% [x, y, width, height] = faceDetection(rawImg)
% ex.: [x, y, width, height] = faceDetection(mRawImg)
%
% Task: To determine the ROI corresponding to the subject's face
% 
% Inputs:
%	-rawImg: a matrix containing the raw image
%
% Outputs:
%	-x: position of the top left corner of the ROI on the x-axis (in pixels)
%	-y: position of the top left corner of the ROI on the y-axis (in pixels)
%	-width: width of the ROI  (in pixels)
%	-height: height of the ROI (in pixels)
%
%
% author: Guillaume Gibert, guillaume.gibert@ecam.fr
% date: 05/02/2024
%%%%%%%%%%%%%%%%%%%%%%%%%

%% TO BE DONE

%% DUMMY IMPLEMENTATION
% USING 
% reads the current image
%mRawImg = imread([imgPath '/' listImg(iCurrentImageIndex).name]);
% displays the current image
%image(mRawImg);
% WE CAN DETERMINE BY HAND THE VALUE OF x, y, width and  height

x = 835;
y = 237;
width = 1100-x;
height = 710 - y;