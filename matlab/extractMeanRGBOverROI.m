function extractMeanRGBOverROI(imgPath, matFilename)
%%%%%%%%%%%%%%%%%%%%%%%%%
% function extractMeanRGBOverROI(imgPath, matFilename)
% ex.: extractMeanRGBOverROI('../img', '../data/meanRGB.mat')
%
% Task: To compute mean R, G, B values over the ROI for all the images
% 
% Inputs:
%	-imgPath: path where images are located
%	-matFilename: filename (mat file) where R, G, B mean values are saved
%
% Outputs: None
%
%
% Author: Guillaume Gibert, guillaume.gibert@ecam.fr
% Date: 12/02/2024
%%%%%%%%%%%%%%%%%%%%%%%%%

% internal variables
rgb = []; % buffer of r, g, b values

% listing all available images
listImg = dir([imgPath  '/*.png']);
totalNumberOfImages = length(listImg);


fprintf('\nCurrent image index /%d : ', totalNumberOfImages);

for l_image=1:totalNumberOfImages

	% displays counter
	if (l_image>1)
		for j=0:log10(l_image-1)
			fprintf('\b'); % delete previous counter display
		end
	end
	fprintf('%d', l_image);
	
	% reads the current image
	mRawImg = imread([imgPath '/' listImg(l_image).name]);
	
	% displays the current image
	%image(mRawImg);
	
	% face detection
	[x, y, width, height] = faceDetection(mRawImg);
	
	% spatial average
	[r, g, b] = spatialAverage(mRawImg, x, y, width, height);
	
	% add r, g, b, values to the buffer
	rgb = [rgb; r g b];
end

 cmd = sprintf('save %s rgb', matFilename)
 exec(cmd)