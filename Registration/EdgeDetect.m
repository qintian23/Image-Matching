function h=EdgeDetect(filename)

f=imread(filename);
figure, imshow(f);

[width, height, depth]=size(f);
g=zeros(width, height);
h=zeros(width, height);
df=im2double(f);

wx=[-1 0; 1 0];
wy=[-1 1; 0 0];
for i = 2:width-1
    for j = 2:height-1
        gw=[df(i,j) df(i,j+1); df(i+1,j) df(i+1, j+1)];
        g(i, j)=sqrt((sum(sum(wx.*gw)))^2+(sum(sum(wy.*gw)))^2);
    end
end

T=0.25*max(g(:));
h=g>=T;
figure, imshow(h);