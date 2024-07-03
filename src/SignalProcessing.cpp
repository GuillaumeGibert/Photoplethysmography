#include "SignalProcessing.h"

float computeTemporalAverage(std::deque<float> vSignal)
{
	return std::accumulate(vSignal.begin(), vSignal.end(), 0.0) / vSignal.size();
}

float computeTemporalStd(std::deque<float> vSignal)
{
	double avg = std::accumulate(vSignal.begin(), vSignal.end(), 0.0) / vSignal.size();
	double sq_sum = std::inner_product(vSignal.begin(), vSignal.end(), vSignal.begin(), 0.0);
	return std::sqrt(sq_sum / vSignal.size() - avg * avg);
}

std::vector<float> normalizeTemporalSignal(std::deque<float> vSignal, float avg, float std)
{
	std::vector<float> vNormalizedSignal;
	
	for (auto& i : vSignal)
	{
		vNormalizedSignal.push_back((i-avg)/std);
	}
	return vNormalizedSignal;
}

std::vector<float> computeFourierTransform(std::vector<float> vSignal)
{
	// compute fft of green signal
	cv::Mat oFourierTransform;
	cv::dft(vSignal, oFourierTransform, cv::DFT_ROWS|cv::DFT_COMPLEX_OUTPUT);
	
	//Make place for both the complex and the real values
	cv::Mat planes[] = {cv::Mat::zeros(vSignal.size(),1, CV_32F), cv::Mat::zeros(vSignal.size(),1, CV_32F)};
	// planes[0] = Re(DFT(I), planes[1] = Im(DFT(I))
	cv::split(oFourierTransform, planes);   
	
	std::vector<float> vPowerSpectrum;
	for (int l=0; l < planes[1].cols; l++)
	{
		float moduleFFT = pow(planes[1].at<float>(0,l),2) + pow(planes[0].at<float>(0,l),2);
		vPowerSpectrum.push_back(sqrt(moduleFFT));
	}
	
	return vPowerSpectrum;
}

int computeHeartRate(std::vector<float> vPowerSpectrum, float lowFreq, float highFreq, float samplingFreq)
{
	double maxValue = 0;
	int maxIndex = 0;
	int minRange = (int) (lowFreq/60 * vPowerSpectrum.size() / samplingFreq);
	int maxRange = (int)(highFreq/60 * vPowerSpectrum.size() / samplingFreq);
		
	for (int l=minRange; l< maxRange; l++)
	{
		if (vPowerSpectrum[l] > maxValue)
		{
			maxValue = vPowerSpectrum[l];
			maxIndex = l;
		}
	}
	return (float)(maxIndex)/vPowerSpectrum.size()*samplingFreq*60;
}
