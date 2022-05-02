#include <opencv2/highgui/highgui.hpp> 
#include <opencv2/imgproc.hpp>
#include <opencv2/xfeatures2d/nonfree.hpp>
#include <iostream>  

using namespace cv;
using namespace std;


int main()
{
    const char* img1 = "../figure/badge.png";
    const char* img2 = "../figure/school_name.png";
    Mat image01 = imread(img1, IMREAD_COLOR);
    Mat image02 = imread(img2, IMREAD_COLOR);
    imshow("p2", image01);
    imshow("p1", image02);

    //�Ҷ�ͼת��  
    Mat image1, image2;
    
    cvtColor(image01, image1, COLOR_RGB2GRAY);
    cvtColor(image02, image2, COLOR_RGB2GRAY);


    //��ȡ������   
    Ptr<FeatureDetector> OrbDetector = ORB::create();
    vector<KeyPoint> keyPoint1, keyPoint2;
    OrbDetector->detect(image1, keyPoint1);
    OrbDetector->detect(image2, keyPoint2);

    //������������Ϊ�±ߵ�������ƥ����׼��    
    Ptr<DescriptorExtractor> OrbDescriptor = ORB::create();
    Mat imageDesc1, imageDesc2;
    OrbDescriptor->compute(image1, keyPoint1, imageDesc1);
    OrbDescriptor->compute(image2, keyPoint2, imageDesc2);

    flann::Index flannIndex(imageDesc1, flann::LshIndexParams(12, 20, 2), cvflann::FLANN_DIST_HAMMING);

    vector<DMatch> GoodMatchePoints;

    Mat macthIndex(imageDesc2.rows, 2, CV_32SC1), matchDistance(imageDesc2.rows, 2, CV_32FC1);
    flannIndex.knnSearch(imageDesc2, macthIndex, matchDistance, 2, flann::SearchParams());

    // Lowe's algorithm,��ȡ����ƥ���
    for (int i = 0; i < matchDistance.rows; i++)
    {
        if (matchDistance.at<float>(i, 0) < 0.6 * matchDistance.at<float>(i, 1))
        {
            DMatch dmatches(i, macthIndex.at<int>(i, 0), matchDistance.at<float>(i, 0));
            GoodMatchePoints.push_back(dmatches);
        }
    }

    Mat first_match;
    drawMatches(image02, keyPoint2, image01, keyPoint1, GoodMatchePoints, first_match);
    imshow("first_match ", first_match);
    imwrite("first_match.jpg", first_match);
    waitKey();
    return 0;
}
