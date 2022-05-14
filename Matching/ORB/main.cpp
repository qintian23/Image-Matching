#include <iostream>
#include <string>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

int main(int* argv, int** argc)
{
	const char* img1 = "../figure/chinese/cheng1.png"; // image1нч
	const char* img2 = "../figure/chinese/all.png";
	Mat imgCat = imread(img1);
	Mat imgSmallCat = imread(img2);

	auto orbDetector = ORB::create();
	vector<KeyPoint> kpCat, kpSmallCat;
	Mat descriptorCat, descriptorSmallCat;

	orbDetector->detectAndCompute(imgCat, Mat(), kpCat, descriptorCat);
	orbDetector->detectAndCompute(imgSmallCat, Mat(), kpSmallCat, descriptorSmallCat);

	Ptr<DescriptorMatcher> matcher = DescriptorMatcher::create(DescriptorMatcher::BRUTEFORCE);
	std::vector<DMatch> matchers;
	matcher->match(descriptorCat, descriptorSmallCat, matchers);

	Mat imgMatches;
	drawMatches(imgCat, kpCat, imgSmallCat, kpSmallCat, matchers, imgMatches);

	//imshow("Cat", imgCat);
	//imshow("SmallCat", imgSmallCat);
	imshow("Match", imgMatches);

	waitKey(0);

	return true;
}