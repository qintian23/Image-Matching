#include <opencv2/highgui/highgui.hpp> 
#include <opencv2/xfeatures2d/nonfree.hpp>
#include <opencv2/imgproc.hpp>
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
    Ptr<FeatureDetector> surfDetector = xfeatures2d::SURF::create(800);  // ����������ֵ��������������ȣ�ֵԽ���Խ�٣�Խ��׼ 
    vector<KeyPoint> keyPoint1, keyPoint2;
    surfDetector->detect(image1, keyPoint1);
    surfDetector->detect(image2, keyPoint2);

    //������������Ϊ�±ߵ�������ƥ����׼��    
    Ptr<DescriptorExtractor> SurfDescriptor = xfeatures2d::SURF::create(800);
    Mat imageDesc1, imageDesc2;
    SurfDescriptor->compute(image1, keyPoint1, imageDesc1);
    SurfDescriptor->compute(image2, keyPoint2, imageDesc2);

    //���ƥ�������㣬����ȡ�������     
    FlannBasedMatcher matcher;
    vector<DMatch> matchePoints;

    matcher.match(imageDesc1, imageDesc2, matchePoints, Mat());
    cout << "total match points: " << matchePoints.size() << endl;


    Mat img_match;
    drawMatches(image01, keyPoint1, image02, keyPoint2, matchePoints, img_match);
    namedWindow("match", 0);
    imshow("match", img_match);
    imwrite("match.jpg", img_match);

    waitKey();
    return 0;
}

