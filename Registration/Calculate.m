function mi=Calculate(a, b)
%{
    参数：
        a   ——输入图像a
        b   ——输入图像b
        mi  ——图像a 和 b 的互信息值

    功能：
        利用一个联合直方图，计算两幅图像的互信息熵值
%}

a=double(a);
b=double(b);
[width, height, depth]=size(a);
if depth>1
    a=rgb2gray(a);
    b=rgb2gray(b);
end
hab=zeros(256, 256);
if max(max(a))~=min(min(a))
    a=(a-min(min(a))) / (max(max(a)) - min(min(a)));
else
    a=zeros(width, height);
end
if max(max(b))-min(min(b))
    b=(b-min(min(b)))/ (max(max(b)) - min(min(b)));
else
    b=zeros(width, height);
end
a=double(int16(a*255))+1;
b=double(int16(b*255))+1;

for i = 1:width
    for j = 1:height
        index_x=a(i,j);
        index_y=b(i,j);
        hab(index_x, index_y)=hab(index_x, index_y)+1;
    end
end

habsum=sum(sum(hab));
index=find(hab~=0);
pab=hab/habsum;
Hab=sum(sum(-pab(index).*log2(pab(index))));

pa=sum(pab');
index=find(pa~=0);
Ha=sum(sum(-pa(index).*log2(pa(index))));
pb=sum(pab);
index=find(pb~=0);
Hb=sum(sum(-pb(index).*log2(pb(index))));

mi=Ha+Hb-Hab;
