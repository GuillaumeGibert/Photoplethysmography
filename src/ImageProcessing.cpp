#include "ImageProcessing.h"

bool loadFaceDetector(cv::CascadeClassifier& faceDetector, std::string sFilename)
{
	bool bIsFaceDetectorLoaded = false;
	
	if( !faceDetector.load(sFilename))
	{
		std::cerr  << "[ERROR] Unable to load face cascade" << std::endl;
	}
	else
	{
		bIsFaceDetectorLoaded = true;
	}
	
	return bIsFaceDetectorLoaded;
}

std::vector<cv::Rect> detectFace(cv::CascadeClassifier& faceDetector, cv::Mat& frame)
{
	// 0- Creates a local variable to store the results
	std::vector<cv::Rect> faceRectangles;
	// 1- Converts color image to grayscale
	cv::Mat frame_gray;
	cv::cvtColor(frame, frame_gray, cv::COLOR_BGR2GRAY);
	// 2- detect face(s)
	faceDetector.detectMultiScale(frame_gray, faceRectangles, 1.1, 3, 0, cv::Size(20, 20));
		
	return faceRectangles;
}

cv::Rect extractForeheadROI(std::vector<cv::Rect>& faceROI)
{
	cv::Rect foreheadROI;
	
	// 0- Checks that the vector is not empty
	if (faceROI.size() > 0)
	{
		// 1- Takes the main face in the image
		foreheadROI = faceROI[0];
		// 2- Crops the image around the forehead
		foreheadROI.height *= 0.3;
	}
	
	return foreheadROI;
}

cv::Mat plotGraph(std::vector<float>& vals, int ySize, int lowerBoundary, int highBoundary)
{
	// Determines the conversion parameters in y axis y = scale * signal_value+ bias
	auto it = minmax_element(vals.begin(), vals.end());
	float scale = 1./ceil(*it.second - *it.first); 
	float bias = *it.first;
	int rows = ySize + 1;
	
	// Creates a square white image of dimension: signal.length*signal.length 
	cv::Mat image = 255*cv::Mat::ones( rows, vals.size(), CV_8UC3 );
	image.setTo(255);
	
	// Plots the signal as line between samples
	for (int i = 0; i < (int)vals.size()-1; i++)
	{
		cv::line(image, cv::Point(i, rows - 1 - (vals[i] - bias)*scale*ySize), cv::Point(i+1, rows - 1 - (vals[i+1] - bias)*scale*ySize), cv::Scalar(255, 0, 0), 1);
	}
	
	// Plots lower and higher boundaries (spectrum)
	if (lowerBoundary>0 & lowerBoundary<vals.size())
		cv::line(image, cv::Point(lowerBoundary, 0), cv::Point(lowerBoundary, rows), cv::Scalar(0, 0, 255), 1);
	if (highBoundary>0 & highBoundary<vals.size())
		cv::line(image, cv::Point(highBoundary, 0), cv::Point(highBoundary, rows), cv::Scalar(0, 0, 255), 1);
	
	// Resizes the image to always be 450 x 450 pixels
	cv::resize(image, image, cv::Size(450, 450), cv::INTER_LINEAR);
	
	return image;
}