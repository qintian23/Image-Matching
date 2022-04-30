#include <string.h>

using namespace std;

class Matrix // 各种格式的文件最终都被转化为像素矩阵
{
    //TODO
};
class ImageImp
{
    public:
        virtual void doPoint(Matrix m) = 0; // 显示像素矩阵m
};

class WinImp : public ImageImp
{
    public:
        void doPoint(Matrix){/*调用Windows系统的绘制函数绘制像素矩阵*/}
};
class LinuxImp : public ImageImp
{
    public:
        void doPoint(Matrix){/*调用Linux系统的绘制函数绘制像素矩阵*/}
};

class Image
{
    public:
        void setImp(ImageImp *imp){this->imp=imp;}
        virtual void parseFile(string filename)=0;

    protected:
        ImageImp *imp;
};

class BMP : public Image
{
    public:
        void parseFile(string filename)
        {
            // 此处解释BMP文件并获得一个像素矩阵对象
            imp->doPoint(m);
        }
};


class GIF : public Image
{
    // TODO
};

class JPEG : public Image
{
    // TODO
};

void main()
{
    // 在Windo操作系统上查看demo.bmp图像文件
    Image *image1 = new BMP();
    ImageImp *imageImp1 =new WinImp();
    image1->setImp(imageImp1);
    image1->parseFile("demo.bmp");
}