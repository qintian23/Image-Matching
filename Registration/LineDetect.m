function LineDetect(filename, direction)
%{
    ������
        filename    ���������ͼ���ļ���
        direction
        �������ֱ�ߵķ���ȡֵΪ0/45/90/135ʱ�ֱ��ʾ��ˮƽֱ�ߣ�б��Ϊ1��ֱ�ߡ���ֱֱ�ߺ�б��Ϊ-1��ֱ��
    ���ܣ�
        �ӱ����ͼ���м���ָ�������ֱ��
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