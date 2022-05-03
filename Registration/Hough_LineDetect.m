function Hough_LineDetect(filename, degree_range, line_llength, dtheta, drho)
%{
    ������
        filename        ���������ͼ���ļ���
        degree_range    �������ֱ�ߵĽǶȷ�Χ��1*2����Ĭ��ֵΪ[-90 90]
        line_length     �������ֱ�ߵ���С���ȣ�Ĭ��ֵΪ100
        dtheta          �����ȵĲ�����Ĭ��ֵΪ1���Ƕȣ�
        drho            ����p�Ĳ�����Ĭ��ֵΪ1�����أ�
    
    ���ܣ�
        �ӱ����ͼ���м�������ǶȺͳ��ȵ�ֱ��
%}

if nargin<5
    drho=1;
end
if nargin<4
    dtheta=1;
end
if nargin<3
    line_length=100;
end
if nargin<2
    degree_range=[-90 90];
end

I = imread(filename);
[width,height,depth]=size(I);
if depth>1
    I=rgb2gray(I);
end
BI=edge(I);

dtheta=dtheta*pi/180;
radian_upper=max(degree_range*pi/180);
radian_lower=min(degree_range*pi/180);
radian_range=radian_upper-radian_lower;

rho_max=(sqrt(width^2+height^2));
nrho=ceil(2*rho_max/drho);
theta_value=[radian_lower:dtheta:radian_upper];
ntheta=length(theta_value);

rho_matrix=zeros(nrho, ntheta);
hough_line=zeros(width, height);

% Hough �任
% ��ͼ��ռ�(x,y)�任�������ռ�(��,��): ��=xcos��+ysin��
[rows, cols]=find(BI);
pointcount=length(rows);
rho_value=zeros(pointcount, ntheta);
for i = 1:pointcount
    m=rows(i);
    n=cols(i);
    for k = 1:ntheta
        rho=(m*cos(theta_value(k)))+(n*sin(theta_value(k)));
        rho_index=round((rho+rho_max)/drho);
        rho_matrix(rho_index,k)=rho_matrix(rho_index,k)+1;
        rho_value(rho_index,k)=rho;
    end
end

% ����ͬһֱ���ϵĵ�
index=find(rho_matrix>line_length);
for k = 1:length(index)
    [rho_th, theta_th]=ind2sub(size(rho_matrix), index(k));
    theta=theta_value(theta_th);
    rho=rho_value(rho_th, theta_th);
    for i = 1:pointcount
        x=rows(i);
        y=cols(i);
        rate=(x*cos(theta)+y*sin(theta))/rho;
        if(rate>1-10^3 & rate<1+10^-3)
            hough_line(x,y)=1;
        end
    end
end

figure; imshow(I); title('ԭʼͼ��');
figure; imshow(BI); title('��Ե����ͼ��');
figure; imshow(hough_line); title('�任��⵽��ֱ��');