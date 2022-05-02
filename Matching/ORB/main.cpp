#include <opencv2/highgui/highgui.hpp> 
#include <opencv2/xfeatures2d/nonfree.hpp>
#include <opencv2/imgproc.hpp>
#include <iostream>
#include <string>
#include <cerrno>
using namespace cv;
using namespace std;

vector<Mat> image;
vector<Mat> grayImage;
enum imageType { OriginalDrawing, ProcessingDiagram};
enum Process
{
    Gray, // 灰度化
    Scaling, // 放缩
    Rotate, // 旋转
    Shear, // 错切
    Affine // 仿射变换
};

// 读取图片
void load()
{
    string filename[] = { "../figure/badge.png" , "../figure/badge.png" }; // 应该对这些文件路径进行检查
    for (int i = 0; i < sizeof(filename)/sizeof(string); i++)
    {
        Mat img = imread(filename[i], IMREAD_COLOR);
        throw(errno);
        image.push_back(img);
    }
}

// 预处理
void pretreatment(Process type=Gray)
{
    if (type == Gray)
    {
        for (auto iter = image.begin(); iter != image.end(); iter++)
        {
            Mat image1;
            cvtColor(*iter, image1, COLOR_RGB2GRAY);
            grayImage.push_back(image1);
        }
    }
}

// 展示图片
void show(string name[], imageType type = OriginalDrawing) // 
{
    int i = 0;
    if (type == OriginalDrawing)
    {
        for (auto iter = image.begin(); iter != image.end(); iter++)
        {
            imshow(name[i++], *iter);
        }
    }
    else
    {
        for (auto iter = grayImage.begin(); iter != grayImage.end(); iter++)
        {
            imshow(name[i++], *iter);
        }
    }
}

// 特征匹配
void featureMatch()
{

}

int main(int argc, char* argv[])
{
       string img1 = "../figure/badge.png";
    string img2 = "../figure/badge.png";
    Mat image01 = imread(img1, IMREAD_COLOR);
    Mat image02 = imread(img2, IMREAD_COLOR);
    imshow("p2", image01);
    imshow("p1", image02);

    //灰度图转换  
    Mat image1, image2;
    cvtColor(image01, image1, COLOR_RGB2GRAY);
    cvtColor(image02, image2, COLOR_RGB2GRAY);


    //提取特征点    
    Ptr<FeatureDetector> surfDetector = xfeatures2d::SURF::create(2000);  // 海塞矩阵阈值，在这里调整精度，值越大点越少，越精准 
    vector<KeyPoint> keyPoint1, keyPoint2;
    surfDetector->detect(image1, keyPoint1);
    surfDetector->detect(image2, keyPoint2);

    //特征点描述，为下边的特征点匹配做准备    
    Ptr<DescriptorExtractor> SurfDescriptor = xfeatures2d::SURF::create();
    Mat imageDesc1, imageDesc2;
    SurfDescriptor->compute(image1, keyPoint1, imageDesc1);
    SurfDescriptor->compute(image2, keyPoint2, imageDesc2);

    FlannBasedMatcher matcher;
    vector<vector<DMatch> > matchePoints;
    vector<DMatch> GoodMatchePoints;

    vector<Mat> train_desc(1, imageDesc1);
    matcher.add(train_desc);
    matcher.train();

    matcher.knnMatch(imageDesc2, matchePoints, 2);
    cout << "total match points: " << matchePoints.size() << endl;

    // Lowe's algorithm,获取优秀匹配点
    for (int i = 0; i < matchePoints.size(); i++)
    {
        if (matchePoints[i][0].distance < 0.6 * matchePoints[i][1].distance)
        {
            GoodMatchePoints.push_back(matchePoints[i][0]);
        }
    }

    Mat first_match;
    drawMatches(image02, keyPoint2, image01, keyPoint1, GoodMatchePoints, first_match);
    imshow("first_match ", first_match);
    waitKey();
    vector<Mat>().swap(image); // 释放内存
    return 0;
}
