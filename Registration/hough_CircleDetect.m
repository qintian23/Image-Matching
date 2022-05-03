function hough_CircleDetect(filename, radius_range, step_angle, step_radius)
%{
    ������
        filename        ���������ͼ���ļ���
        radius_range    �������Բ�İ뾶��Χ��1*2����Ĭ��ֵΪ[10 100]
        step_angle      �����ǶȲ�����Ĭ��ֵΪ5���Ƕȣ�
        step_radius         �����뾶������Ĭ��ֵΪ1�����أ�
    
    ���ܣ�
        �ӱ����ͼ���м�������ǶȺͳ��ȵ�ֱ��
%}

if nargin<4
    step_radius=1;
end
if nargin<3
    step_angle=5;
end
if nargin<2
    radius_range=[10 100];
end
radius_min=min(radius_range);
radius_max=max(radius_range);
step_angle=step_angle*pi/180;

I = imread(filename);
[m,n,depth]=size(I);
if depth>1
    I=rgb2gray(I);
end
BI=edge(I);

[rows, cols]=find(BI);
pointcount=size(rows);

RadiusCount=ceil((radius_max-radius_min)/step_radius);
AngleCount=ceil(2*pi/step_angle);
hough_space=zeros(m,n,RadiusCount);

% Hough �任
% ��ͼ��ռ�(x,y)�任�������ռ�(a,b,r)
% a=x-r*cos(��)
% b=y-r*sin(��)
for i = 1:pointcount
    for r = 1:RadiusCount
        for k = 1:AngleCount
            a=round(rows(i)-(radius_min+(r-1)*step_radius)*cos(k*step_angle));
            b=round(cols(i)-(radius_min+(r-1)*step_radius)*sin(k*step_angle));
            if(a>0 & a<=m & b>0 & b<=n)
                hough_space(a,b,r)=hough_space(a,b,r)+1;
            end
        end
    end
end

% ����ͬһԲ�ϵĵ�
thresh=0.7;
max_PointCount=max(max(max(hough_space)));
index=find(hough_space>=max_PointCount*thresh);
length=size(index);
hough_circle=zeros(m,n);
size_hough_space=size(hough_space);
for i = 1:pointcount
    for k = 1:length
        [a,b,r]=ind2sub(size_hough_space, index(k));
        rate=((rows(i)-a)^2+(cols(i)-b)^2)/(radius_min+(r-1)*step_radius)^2;
        if(rate<1.1)
            hough_circle(rows(i), cols(i))=1;
        end
    end
end

figure; imshow(I); title('ԭʼͼ��');
figure; imshow(BI); title('��Ե����ͼ��');
figure; imshow(hough_circle); title('�任��⵽��Բ');