#include <opencv2/highgui/highgui.hpp> 
#include <opencv2/xfeatures2d/nonfree.hpp>
#include <opencv2/imgproc.hpp>
#include <iostream>

using namespace cv;
using namespace std;


int main()
{
    //const char* img1 = "../figure/badge.png";
    //const char* img2 = "../figure/school_name.png";

        // Chinese
    //const char* img1 = "../figure/chinese/cheng.png";  // 5000,2000，对
    //const char* img1 = "../figure/chinese/cheng1.png"; // 5000,2000，对
    //const char* img1 = "../figure/chinese/dong.png"; // 5000,2000，对
    const char* img1 = "../figure/chinese/dong1.png";  // 5000,2000，对
    //const char* img1 = "../figure/chinese/lin.png"; // 5000,2000，对
    //const char* img1 = "../figure/chinese/lin1.png"; //  5000,2000，对
    //const char* img1 = "../figure/chinese/wan.png";// 5000,2000，对
    //const char* img1 = "../figure/chinese/wan1.png";// 5000,2000，对
    //const char* img1 = "../figure/chinese/xi.png";// 5000,2000，对
    //const char* img1 = "../figure/chinese/xi1.png";// 5000,2000，对
    //const char* img1 = "../figure/chinese/zhang.png";// 5000,2000，对
    //const char* img1 = "../figure/chinese/zhang1.png";// 5000,2000，对

    // bird
    //const char* img1 = "../figure/bird/bird_acc.jpg";  // 5000,2000，对
    //const char* img1 = "../figure/bird/bird_acc_1.jpg"; // 5000,2000，对
    //const char* img1 = "../figure/bird/bird_anianiau.jpg"; // 5000,2000，对
    //const char* img1 = "../figure/bird/bird_anianiau_1.jpg";  // 5000,2000，对
    //const char* img1 = "../figure/bird/bird_aoc.jpg"; // 5000,2000，对
    //const char* img1 = "../figure/bird/bird_aoc_1.jpg"; // 5000,2000，对
    //const char* img1 = "../figure/bird/bird_ap.jpg";// 5000,2000，对
    //const char* img1 = "../figure/bird/bird_ap_1.jpg";// 5000,2000，对
    //const char* img1 = "../figure/bird/bird_apapane.jpg";// 5000,2000，对
    //const char* img1 = "../figure/bird/bird_apapane_1.jpg";// 5000,2000，对
    //const char* img1 = "../figure/bird/bird_booby.jpg";// 5000,2000，对
    //const char* img1 = "../figure/bird/bird_booby_1.jpg";// 5000,2000，对

    //const char* img2 = "../figure/bird/all.png";
    const char* img2 = "../figure/chinese/all.png";

    Mat image01 = imread(img1, IMREAD_COLOR);
    Mat image02 = imread(img2, IMREAD_COLOR);
    //imshow("p2", image01);
    //imshow("p1", image02);

    //灰度图转换  
    Mat image1, image2;
    cvtColor(image01, image1, COLOR_RGB2GRAY);
    cvtColor(image02, image2, COLOR_RGB2GRAY);


    //提取特征点    
    Ptr<FeatureDetector> surfDetector = xfeatures2d::SURF::create(2000);  // 海塞矩阵阈值，在这里调整精度，值越大点越少，越精准 
    vector<KeyPoint> keyPoint1, keyPoint2;
    surfDetector->detect(image1, keyPoint1);
    surfDetector->detect(image2, keyPoint2);

    if (keyPoint1.size() == 0)
    {
        cout << "image1无法检测出特征点！！" << endl;
        return -1;
    }
    if (keyPoint2.size() == 0)
    {
        cout << "image2无法检测出特征点！！" << endl;
        return -1;
    }


    //特征点描述，为下边的特征点匹配做准备      
    Ptr<DescriptorExtractor> SiftDescriptor = SIFT::create(2000);
    Mat imageDesc1, imageDesc2;
    SiftDescriptor->compute(image1, keyPoint1, imageDesc1);
    SiftDescriptor->compute(image2, keyPoint2, imageDesc2);

    //获得匹配特征点，并提取最优配对     
    FlannBasedMatcher matcher;
    vector<DMatch> matchePoints;

    matcher.match(imageDesc1, imageDesc2, matchePoints, Mat());
    cout << "total match points: " << matchePoints.size() << endl;


    Mat img_match;
    drawMatches(image01, keyPoint1, image02, keyPoint2, matchePoints, img_match);

    imshow("match", img_match);
    //imwrite("first_match.jpg", first_match);

    waitKey();
    return 0;
}
