function plot_field(X, Y, VecFld, CorrectIndex, normal, siz)
%   PLOT_FIELD(X, Y, VECFLD, CORRECTINDEX, NARMAL, SIZ)
%   plots the vector field use four color arrows, in which blue arrow
%   denotes true positive, red arrow denotes false positive, green arrow
%   denotes false negative, black arrow denotes true negative. Then we
%   visualize the field use toolbox
%
% Input:
%   X, Y: Original data.
%
%   VecFld: Output of VFC.
%
%   CorrectIndex: Correct match Indexes.
%
%   normal: Normalization information. 
%
%   siz: Image size.

% Authors: Jiayi Ma (jyma2010@gmail.com)
% Date:    04/17/2012

% plot the vector field use four color arrows
VFCIndex = VecFld.VFCIndex;
TruePos = intersect(VFCIndex, CorrectIndex);%Ture positive
FalsePos = setdiff(VFCIndex, CorrectIndex); %False positive
FalseNeg = setdiff(CorrectIndex, VFCIndex); %False negative
TrueNeg = setdiff(1:size(X,1), union(VFCIndex, CorrectIndex)); %true negative

k=0; %0 or 1
figure,
% quiver(X(TrueNeg, 1), X(TrueNeg, 2), (Y(TrueNeg, 1)-X(TrueNeg, 1)), (Y(TrueNeg, 2)-X(TrueNeg, 2)), k, 'k'), hold on
% quiver(X(FalsePos, 1), X(FalsePos, 2), (Y(FalsePos, 1)-X(FalsePos, 1)), (Y(FalsePos, 2)-X(FalsePos, 2)), k, 'r'), hold on
% quiver(X(FalseNeg, 1), X(FalseNeg, 2), (Y(FalseNeg, 1)-X(FalseNeg, 1)), (Y(FalseNeg, 2)-X(FalseNeg, 2)), k, 'g'),hold on 
% quiver(X(TruePos, 1), X(TruePos, 2), (Y(TruePos, 1)-X(TruePos, 1)), (Y(TruePos, 2)-X(TruePos, 2)), k, 'b'); hold off
quiver(X(TrueNeg, 1), siz(1)-X(TrueNeg, 2), (Y(TrueNeg, 1)-X(TrueNeg, 1)), (-Y(TrueNeg, 2)+X(TrueNeg, 2)), k, 'k'), hold on
quiver(X(FalsePos, 1), siz(1)-X(FalsePos, 2), (Y(FalsePos, 1)-X(FalsePos, 1)), (-Y(FalsePos, 2)+X(FalsePos, 2)), k, 'r'), hold on
quiver(X(FalseNeg, 1), siz(1)-X(FalseNeg, 2), (Y(FalseNeg, 1)-X(FalseNeg, 1)), (-Y(FalseNeg, 2)+X(FalseNeg, 2)), k, 'g'),hold on 
quiver(X(TruePos, 1), siz(1)-X(TruePos, 2), (Y(TruePos, 1)-X(TruePos, 1)), (-Y(TruePos, 2)+X(TruePos, 2)), k, 'b');
axis equal
axis([0 siz(2) 0 siz(1)]);
set(gca,'XTick',-2:1:-1)
set(gca,'YTick',-2:1:-1)
hold off
%  hold on; plot(X(TruePos, 1), X(TruePos, 2), 'r.', 'MarkerSize', 6);
%  hold on; plot(X(FalsePos, 1), X(FalsePos, 2), 'r.', 'MarkerSize', 6);

% Create grid points for field visualization algorithm in the toolbox.
interval = 10;
[Gridx, Gridy] = meshgrid(1:interval:siz(2), 1:interval:siz(1));
Grid = [Gridx(:), Gridy(:)];

m=size(Grid,1);
nGrid=Grid-repmat(normal.xm,m,1);
nGrid=nGrid/normal.xscale;

% Estimate the output at grid points by VFC
GridV = get_V(nGrid, VecFld.X, VecFld.C, VecFld.beta);
GridV=(GridV+nGrid)*normal.yscale+repmat(normal.ym,size(GridV,1),1)-Grid;

U = reshape(GridV(:,1), size(Gridx));
V = reshape(GridV(:,2), size(Gridx));

maxDimension = 512;
[width,height] = size(U);
zoomFactor = maxDimension / max([width,height]);
figure;
LICimage = plotvfield(V, U, zoomFactor, 1, autumn, [1 1 height width], 'ef'); 
LICimage = LICimage(end:-1:1, :, :);
imshow(LICimage); 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function GridV = get_V(nGrid, Y, C, beta)
GridV = zeros(size(nGrid));
for i = 1:size(nGrid, 1)
    GridK = con_K(nGrid(i,:), Y, beta);
    GridV(i,:) = GridK'*C;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function K=con_K(x,y,beta)
[n, d]=size(x); [m, d]=size(y);
K=repmat(x,[1 1 m])-permute(repmat(y,[1 1 n]),[3 2 1]);
K=squeeze(sum(K.^2,2));
K=-beta * K;
K=exp(K);