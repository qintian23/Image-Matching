#ifndef _MATCH_H_
#define _MATCH_H_

#include <iostream>
#include <opencv2/core/core.hpp>
#include <opencv2/features2d/features2d.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/xfeatures2d/nonfree.hpp>
#include <opencv2/imgproc.hpp>
#include "vfc.h"
#include <iostream>

int orb_match(const char* img1, const char* img2);
int sift_match(const char* img1, const char* img2);
int suft_match(const char* img1, const char* img2);
int vfc_match(const char* img1, const char* img2);

#endif // !_MATCH_H_
