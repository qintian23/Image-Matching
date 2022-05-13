// This is a demo for mismatch removal by vector field consensus (VFC)
//
// Reference
// [1] Jiayi Ma, Ji Zhao, Jinwen Tian, Alan Yuille, and Zhuowen Tu.
//     Robust Point Matching via Vector Field Consensus, 
//     IEEE Transactions on Image Processing, 23(4), pp. 1706-1721, 2014
// [2] Jiayi Ma, Ji Zhao, Jinwen Tian, Xiang Bai, and Zhuowen Tu.
//     Regularized Vector Field Learning with Sparse Approximation for Mismatch Removal, 
//     Pattern Recognition, 46(12), pp. 3519-3532, 2013
//
// The main function is based on the tutorial of opencv:
// http://docs.opencv.org/doc/tutorials/features2d/feature_description/feature_description.html#feature-description

//#include <stdio.h>
#include <iostream>
#include <opencv2/highgui/highgui.hpp> 
#include <opencv2/xfeatures2d/nonfree.hpp>
#include <opencv2/imgproc.hpp>
#include <iostream>
#include "vfc.h"

using namespace cv;

/** @function main */
int main()
{

	const char* img1 = "../figure/badge.png";
	const char* img2 = "../figure/school_name.png";
	//const char* img1 = "church1.jpg";
	//const char* img2 = "church2.jpg";
	Mat img_1 = imread(img1, IMREAD_GRAYSCALE);
	Mat img_2 = imread(img2, IMREAD_GRAYSCALE);

	if (!img_1.data || !img_2.data)
	{
		return -1;
	}

	//-- Step 1: Detect the keypoints using SURF Detector
	int minHessian = 400;

	Ptr<FeatureDetector> detector = xfeatures2d::SURF::create(minHessian);

	std::vector<KeyPoint> keypoints_1, keypoints_2;

	detector->detect(img_1, keypoints_1);
	detector->detect(img_2, keypoints_2);

	//-- Step 2: Calculate descriptors (feature vectors)
	//xfeatures2d::SurfDescriptorExtractor extractor;
	Ptr<DescriptorExtractor> extractor = xfeatures2d::SURF::create();

	Mat descriptors_1, descriptors_2;

	extractor->compute(img_1, keypoints_1, descriptors_1);
	extractor->compute(img_2, keypoints_2, descriptors_2);

	//-- Step 3: Matching descriptor vectors with a brute force matcher
	BFMatcher matcher(NORM_L2);
	std::vector< DMatch > matches;
	matcher.match(descriptors_1, descriptors_2, matches);

	//-- Draw matches
	Mat img_matches;
	drawMatches(img_1, keypoints_1, img_2, keypoints_2, matches, img_matches);

	//-- Show detected matches
	imshow("Matches", img_matches);

	waitKey(1);

	//-- Step 4: Remove mismatches by vector field consensus (VFC)
	// preprocess data format
	vector<Point2f> X;
	vector<Point2f> Y;
	X.clear();
	Y.clear();
	for (unsigned int i = 0; i < matches.size(); i++) {
		int idx1 = matches[i].queryIdx;
		int idx2 = matches[i].trainIdx;
		X.push_back(keypoints_1[idx1].pt);
		Y.push_back(keypoints_2[idx2].pt);
	}
	// main process
	double t = (double)getTickCount();
	VFC myvfc;
	myvfc.setData(X, Y);
	myvfc.optimize();
	vector<int> matchIdx = myvfc.obtainCorrectMatch();
	t = 1000 * ((double)getTickCount() - t) / getTickFrequency();
	cout << "Times (ms): " << t << endl;

	// postprocess data format
	std::vector< DMatch > correctMatches;
	std::vector<KeyPoint> correctKeypoints_1, correctKeypoints_2;
	correctMatches.clear();
	for (unsigned int i = 0; i < matchIdx.size(); i++) {
		int idx = matchIdx[i];
		correctMatches.push_back(matches[idx]);
		correctKeypoints_1.push_back(keypoints_1[idx]);
		correctKeypoints_2.push_back(keypoints_2[idx]);
	}
	//-- Draw mismatch removal result
	Mat img_correctMatches;
	drawMatches(img_1, keypoints_1, img_2, keypoints_2, correctMatches, img_correctMatches);

	//-- Show mismatch removal result
	imshow("Detected Correct Matches", img_correctMatches);
	waitKey(0);

	//-- write image
	//imwrite("C:\\intial_match.jpg", img_matches);
	//imwrite("C:\\result.jpg", img_correctMatches);

	waitKey();
	return 0;
}



