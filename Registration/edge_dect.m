function h=edge_dect(filename, type)

f=imread(filename);
[width, height, depth] = size(f);
g=zeros(width, height);
df=im2double(f);

switch type
    case 'sobel'
        wx=[-1 -2 -1; 0 0 0; 1 2 1];
        wy=[-1 0 1; -2 0 2; -1 0 1];
        for i = 2:width-1
            for j = 2:height-1
                gw=[df(i-1, j-1) df(i-1, j) df(i-1, j+1);
                    df(i, j-1) df(i, j) df(i, j+1); 
                    df(i+1, j-1) df(i+1, j) df(i+1, j+1)];
                g(i,j)=sqrt((sum(sum(wx.*gw)))^2 + (sum(sum(wy.*gw)))^2) / 8;
            end
        end
    case 'prewitt'
        wx=[-1 -1 -1; 0 0 0; 1 1 1];
        wy=[-1 0 1; -1 0 1; -1 0 1];
        for i = 2:width-1
            for j = 2:height-1
                gw=[df(i-1, j-1) df(i-1, j) df(i-1, j+1);
                    df(i, j-1) df(i, j) df(i, j+1); 
                    df(i+1, j-1) df(i+1, j) df(i+1, j+1)];
                g(i,j)=sqrt((sum(sum(wx.*gw)))^2 + (sum(sum(wy.*gw)))^2) / 6;
            end
        end
    case 'robers'
        wx=[-1 0; 0 1];
        wy=[0 -1; 1 0];
        for i = 1:width-1
            for j = 1:height-1
                gw=[df(i, j) df(i, j+1); df(i+1, j) df(i+1, j+1)];
                g(i,j)=sqrt((sum(sum(wx.*gw)))^2 + (sum(sum(wy.*gw)))^2) / 2;
            end
        end
    case 'robinson'
        wx=[1 1 1; 1 -2 1; -1 -1 -1];
        wy=[-1 1 1; -1 -2 1; -1 1 1];
        for i = 2:width-1
            for j = 2:height-1
                gw=[df(i-1, j-1) df(i-1, j) df(i-1, j+1);
                    df(i, j-1) df(i, j) df(i, j+1); 
                    df(i+1, j-1) df(i+1, j) df(i+1, j+1)];
                g(i,j)=sqrt((sum(sum(wx.*gw)))^2 + (sum(sum(wy.*gw)))^2) / 10;
            end
        end
    case 'kirsch'
        wx=[3 3 3; 3 0 3; -5 -5 -5];
        wy=[-5 3 3; -5 0 3; -5 3 3];
        for i = 2:width-1
            for j = 2:height-1
                gw=[df(i-1, j-1) df(i-1, j) df(i-1, j+1);
                    df(i, j-1) df(i, j) df(i, j+1); 
                    df(i+1, j-1) df(i+1, j) df(i+1, j+1)];
                g(i,j)=sqrt((sum(sum(wx.*gw)))^2 + (sum(sum(wy.*gw)))^2) / 30;
            end
        end
    otherwise
        return
end

t=0.25*max(g(:));
h=g>=t;
figure, imshow(h);