function hr = main(imgPath, bufferSize, bufferShift, fps, hrFrequencyRange)
%%%%%%%%%%%%%%%%%%%%%%%%%
% function hr = main(imgPath, bufferSize, bufferShift, fps, hrFrequencyRange)
% ex.: hr = main('../img', 30, 1, 60, [0.8 4])
%
% Task: To compute HR from set of images
% 
% Inputs:
%	-imgPath: path where images are located
%	-bufferSize: size of the image buffer to process in second
%	-bufferShift: temporal shift of the buffer to process in second
%	-fps: number of frames per second (in Hz)
%	-hrFrequencyRange: frenquency range in Hz to look for heart rate signal
%
% Outputs:
%	-hr: heart rate values over time in bpm
%
%  Note: images were extracted with the following command: ffmpeg -i "video.mkv" ../img/gg_%04d.png
%
% Author: Guillaume Gibert, guillaume.gibert@ecam.fr
% Date: 05/02/2024
%%%%%%%%%%%%%%%%%%%%%%%%%

% internal variables
bAreImagesToProcess = 1;
iCurrentImageIndex = 1;
iCurrentBufferIndex = 1;
rgb = []; % buffer of r, g, b values
bIsBufferInConstruction = 1;
hr = [];

% listing all available images
listImg = dir([imgPath  '/*.png']);
totalNumberOfImages = length(listImg);

while (bAreImagesToProcess)
	fprintf('\n============\nCurrent Buffer Index : %d', iCurrentBufferIndex);
	
	fprintf('\nCurrent Buffer Size /%d : ', bufferSize*fps);
	while (bIsBufferInConstruction)
		% displays counter
		
		if (size(rgb, 1)>1)
			for j=0:log10(size(rgb, 1)-1)
				fprintf('\b'); % delete previous counter display
			end
		end
		fprintf('%d', size(rgb, 1));
		%pause(0.05);
	
		% reads the current image
		mRawImg = imread([imgPath '/' listImg(iCurrentImageIndex).name]);
		
		% displays the current image
		%image(mRawImg);
		
		% face detection
		[x, y, width, height] = faceDetection(mRawImg);
		
		% spatial average
		[r, g, b] = spatialAverage(mRawImg, x, y, width, height);
		
		% add r, g, b, values to the buffer
		rgb = [rgb; r g b];
		
		% increments current image index
		iCurrentImageIndex = iCurrentImageIndex + 1;
		
		if (size(rgb, 1) >= bufferSize * fps)
			bIsBufferInConstruction = 0;
		end
	end
	
	% determines the temporal average and standard deviation of the buffer signals
	[avgRGB, stdRGB] = determineAvgStd(rgb);
	
	% normalises the rgb buffer
	rgbNorm = normalizeSignals(rgb, avgRGB, stdRGB);
	
	% applies ICA
	%% TO BE DONE
	% in the meantine we will use the green channel (see Verkruysse et al. article)
	
	% computes power spectrum
	[f, powerSpectrum] = computePowerSpectrum(rgbNorm(:,2), fps, hrFrequencyRange, 0);
	
	% finds the peak in a given frequency range and determines the HR frequency
	hrBPM = findPeak(f, powerSpectrum, hrFrequencyRange);
	
	% displays HR
	%% TO BE CHOSEN
	fprintf('\nHeart rate = %d bpm\n', hrBPM)
	
	% stores current HR
	hr = [hr; hrBPM];
	
	% discard the first bufferShift*fps values
	rgb(1:bufferShift*fps, :) = [];
	bIsBufferInConstruction = 1;
	iCurrentBufferIndex = iCurrentBufferIndex + 1;
	
	% checks if there are enough images to process
	if (iCurrentImageIndex + bufferShift*fps > totalNumberOfImages)
		bAreImagesToProcess = 0;
	end
	
end

% plots HR evolution over time
figure;
plot(hr);
xlabel('time (shiftBuffer)');
ylabel('Heart Rate (bpm)');

