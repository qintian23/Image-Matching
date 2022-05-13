#include "match.h"

using namespace std;
using namespace cv;

int orb_match(const char* img1, const char* img2)
{
    Mat img_1 = imread(img1, IMREAD_COLOR);
    Mat img_2 = imread(img2, IMREAD_COLOR);
    //-- 初始化
    std::vector<KeyPoint> keypoints_1, keypoints_2; // 角点
    Mat descriptors_1, descriptors_2; // 描述子
    Ptr<FeatureDetector> detector = ORB::create(5000);
    Ptr<DescriptorExtractor> descriptor = ORB::create(2000);

    Ptr<DescriptorMatcher> matcher = DescriptorMatcher::create("BruteForce-Hamming");

    //-- 第一步:检测 Oriented FAST 角点位置
    detector->detect(img_1, keypoints_1);
    detector->detect(img_2, keypoints_2);

    if (keypoints_1.size() == 0)
    {
        cout << "image1无法检测出特征点！！" << endl;
        return -1;
    }
    if (keypoints_2.size() == 0)
    {
        cout << "image2无法检测出特征点！！" << endl;
        return -1;
    }

    //-- 第二步:根据角点位置计算 BRIEF 描述子
    descriptor->compute(img_1, keypoints_1, descriptors_1);
    descriptor->compute(img_2, keypoints_2, descriptors_2);

    Mat outimg1;
    drawKeypoints(img_1, keypoints_1, outimg1, Scalar::all(-1), DrawMatchesFlags::DEFAULT);
    //imshow("ORB特征点", outimg1);

    //-- 第三步:对两幅图像中的BRIEF描述子进行匹配，使用 Hamming 距离
    vector<DMatch> matches;
    matcher->match(descriptors_1, descriptors_2, matches);

    //-- 第四步:匹配点对筛选
    double min_dist = 10000, max_dist = 0;

    //找出所有匹配之间的最小距离和最大距离, 即是最相似的和最不相似的两组点之间的距离
    for (int i = 0; i < descriptors_1.rows; i++)
    {
        double dist = matches[i].distance;
        if (dist < min_dist) min_dist = dist;
        if (dist > max_dist) max_dist = dist;
    }

    // 仅供娱乐的写法
    min_dist = min_element(matches.begin(), matches.end(), [](const DMatch& m1, const DMatch& m2) {return m1.distance < m2.distance; })->distance;
    max_dist = max_element(matches.begin(), matches.end(), [](const DMatch& m1, const DMatch& m2) {return m1.distance < m2.distance; })->distance;

    printf("-- Max dist : %f \n", max_dist);
    printf("-- Min dist : %f \n", min_dist);

    //当描述子之间的距离大于两倍的最小距离时,即认为匹配有误.但有时候最小距离会非常小,设置一个经验值30作为下限.
    std::vector< DMatch > good_matches;
    for (int i = 0; i < descriptors_1.rows; i++)
    {
        if (matches[i].distance <= max(2 * min_dist, 30.0))
        {
            good_matches.push_back(matches[i]);
        }
    }

    //-- 第五步:绘制匹配结果
    Mat img_match;
    Mat img_goodmatch;
    drawMatches(img_1, keypoints_1, img_2, keypoints_2, matches, img_match);
    drawMatches(img_1, keypoints_1, img_2, keypoints_2, good_matches, img_goodmatch);
    imshow("所有匹配点对", img_match);
    imshow("优化后匹配点对", img_goodmatch);

    //imwrite("../figure/chinese/ORB.png", img_match);
    //imwrite("../figure/chinese/ORB_good.png", img_goodmatch);
    //imwrite("ORB_feature.png", outimg1);

    waitKey(0);
	return 0;
}

int sift_match(const char* img1, const char* img2)
{
    Mat image01 = imread(img1, IMREAD_COLOR);
    Mat image02 = imread(img2, IMREAD_COLOR);
    //imshow("p2", image01);
    //imshow("p1", image02);

    //灰度图转换  
    Mat image1, image2;
    cvtColor(image01, image1, COLOR_RGB2GRAY);
    cvtColor(image02, image2, COLOR_RGB2GRAY);


    //提取特征点    
    Ptr<FeatureDetector> siftDetector = SIFT::create(5000);  // 海塞矩阵阈值，在这里调整精度，值越大点越少，越精准 
    vector<KeyPoint> keyPoint1, keyPoint2;
    siftDetector->detect(image1, keyPoint1);
    siftDetector->detect(image2, keyPoint2);

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

int suft_match(const char* img1, const char* img2)
{
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
    Ptr<DescriptorExtractor> SiftDescriptor = xfeatures2d::SURF::create(2000);
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

int vfc_match(const char* img1, const char* img2)
{
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

