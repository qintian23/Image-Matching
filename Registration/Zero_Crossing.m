function Zero_Crossing(filename)

f=imread(filename);
figure, imshow(f);
[width, height, depth]=size(f);
g1=zeros(width, height);
g2=g1;
df=im2double(f);
w=[0 0 -1 0 0; 0 -1 -2 -1 0; -1 -2 16 -2 -1; 0 -1 -2 -1 0; 0 0 -1 0 0];
for i = 3:width-2
    for j = 3:height-2
       gw=[ df(i-2, j-2) df(i-2, j-1) df(i-2, j) df(i-2, j+1) df(i-2, j+2) ;
            df(i-1, j-2) df(i-1, j-1) df(i-1, j) df(i-1, j+1) df(i-1, j+2) ;
            df(i, j-2) df(i, j-2) df(i, j) df(i, j+1) df(i, j+2) ;
            df(i+1, j-2) df(i+1, j-2) df(i+1, j) df(i+1, j+1) df(i+1, j+2) ;
            df(i+2, j-2) df(i+2, j-2) df(i+2, j) df(i+2, j+1) df(i+2, j+2) ] ;
        g2(i,j)=sum(sum(w.*gw));
    end
end

wx=[-1 -2 -1; 0 0 0; 1 2 1];
wy=[-1 0 1; -2 0 2; -1 0 1];
for i = 2:width-1
    for j = 2:height-1
        gw=[ df(i-1, j-1) df(i-1, j) df(i-1, j+1);
             df(i, j-1) df(i, j) df(i, j+1); 
             df(i+1, j-1) df(i+1, j) df(i+1, j+1)];
        g1(i,j)=sqrt((sum(sum(wx.*gw)))^2 + (sum(sum(wy.*gw)))^2)/2;
    end
end

for i = 1:width-1
    for j = 1:height-1
        if g2(i,j)>0
            if (g2(i+1, j)<0 || g2(i, j+1)<0 || g2(i+1, j+1)<0)
                g2(i,j)=1;
            else
                g2(i,j)=0;
            end
        elseif g2(i,j)<0
            if (g2(i+1, j)>0 || g2(i, j+1)>0 || g2(i+1, j+1)>0 )
                g2(i,j)=1;
            else
                g2(i,j)=0;
            end
        else
            g2(i,j)=0;
        end
    end
end

g1=g1>=0.25*max(g1(:));
g=g1.*g2;
figure, imshow(g);