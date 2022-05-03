function LineDetect(filename, direction)
%{
    参数：
        filename    ——被检测图像文件名
        direction
        ——检测直线的方向：取值为0/45/90/135时分别表示的水平直线，斜率为1的直线、垂直直线和斜率为-1的直线
    功能：
        从被检测图像中检测出指定方向的直线
%}
f = imread(filename);
f = rgb2gray(f);
figure, imshow(f)
[width, height, depth]=size(f);
number = 100;
h=zeros(width, height);
if number>width*height
    number=width*height;
end
df=im2double(f);

switch direction
    case 0
        w=[-1 -1 -1; 4 4 4; -1 -1 -1];
    case 45
        w=[-1 -1 4; -1 4 -1; 4 -1 -1];
    case 90
        w=[-1 4 -1; -1 4 -1; -1 4 -1];
    case 135
        w=[4 -1 -1; -1 4 -1; -1 -1 4];
    ortherwise
        w=[-1 -1 -1; 4 4 4; -1 -1 -1];
end

g=imfilter(df,w);
g=abs(g)./4;
[data index]=sort(g(:));
T=data(width*height-number+1);

for i = 1:width
    for j=1:height
        if g(i,j)>=T
            h(i,j)=1;
        end
    end
end
figure,imshow(h)