#include <iostream>
#include <string>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

int main(int* argv, int** argc)
{
    // Chinese
    //const char* img1 = "../figure/chinese/cheng.png";  // 5000,2000，对
    //const char* img1 = "../figure/chinese/cheng1.png"; // image1无
    //const char* img1 = "../figure/chinese/dong.png"; // 5000,2000，对
    //const char* img1 = "../figure/chinese/dong1.png";  // image1无
    //const char* img1 = "../figure/chinese/lin.png"; // 5000,2000，对
    //const char* img1 = "../figure/chinese/lin1.png"; // image1无
    //const char* img1 = "../figure/chinese/wan.png";// image1无
    //const char* img1 = "../figure/chinese/wan1.png";// image1无
    //const char* img1 = "../figure/chinese/xi.png";// 5000,2000，对
    //const char* img1 = "../figure/chinese/xi1.png";// image1无
    //const char* img1 = "../figure/chinese/zhang.png";// image1无
    //const char* img1 = "../figure/chinese/zhang1.png";// 5000，2000，误

    // bird
    //const char* img1 = "../figure/bird/bird_acc.jpg";  // 5000,2000，对
    //const char* img1 = "../figure/bird/bird_acc_1.jpg"; // 5000,2000，对
    //const char* img1 = "../figure/bird/bird_anianiau.jpg"; // 5000,2000，对
    //const char* img1 = "../figure/bird/bird_anianiau_1.jpg";  // 5000,2000，对
    //const char* img1 = "../figure/bird/bird_aoc.jpg"; // 5000,2000，对
    //const char* img1 = "../figure/bird/bird_aoc_1.jpg"; // 5000,2000，对
    //const char* img1 = "../figure/bird/bird_ap.jpg";// 5000,2000，错
    //const char* img1 = "../figure/bird/bird_ap_1.jpg";// 5000,2000，对
    //const char* img1 = "../figure/bird/bird_apapane.jpg";// 5000,2000，对
    //const char* img1 = "../figure/bird/bird_apapane_1.jpg";// 5000,2000，错
    //const char* img1 = "../figure/bird/bird_booby.jpg";// 5000,2000，对
    const char* img1 = "../figure/bird/bird_booby_1.jpg";// 5000,2000，对

    const char* img2 = "../figure/bird/all.png";
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