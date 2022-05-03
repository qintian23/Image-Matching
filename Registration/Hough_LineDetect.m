function Hough_LineDetect(filename, degree_range, line_llength, dtheta, drho)
%{
    参数：
        filename        ——被检测图像文件名
        degree_range    ——检测直线的角度范围，1*2矩阵；默认值为[-90 90]
        line_length     ——检测直线的最小长度；默认值为100
        dtheta          ——θ的步长；默认值为1（角度）
        drho            ——p的步长；默认值为1（像素）
    
    功能：
        从被检测图像中检测出满足角度和长度的直线
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

% Hough 变换
% 将图像空间(x,y)变换到参数空间(ρ,θ): ρ=xcosθ+ysinθ
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

% 搜索同一直线上的点
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

figure; imshow(I); title('原始图像');
figure; imshow(BI); title('边缘检测后图像');
figure; imshow(hough_line); title('变换检测到的直线');