clear
close all;
% initialization;  %run it only at the first time
addpath('./data');
%% parameters setting
lambda    = 0.8 ; %% threshold of distinguishing inliers and outliers
numNeigh  = 6;    %% size of the neighborhood
tau       = 0.2;  %% threshold of local topological cost in Eq. (13)
r         = 0.02; %% radius in mean shift clustering
mu        = 0.3;  %% weight of the global consensus distance
%% input image pair with putative matches or without putative matches
%%% data from KITTI05

fn_l = 'kitti05_1804.png';
fn_r = 'kitti05_1812.png';
Ia = imread(fn_l);
Ib = imread(fn_r);
load kitti05_1804vs1812.mat;

%%% data from Malaga 6L

% fn_l = 'malaga_192.jpg';
% fn_r = 'malaga_2784.jpg';
% Ia = imread(fn_l);
% Ib = imread(fn_r);
% load malaga_0192vs2784.mat;

%%% no initial correspondence

% fn_l = 'malaga_192.jpg';
% fn_r = 'malaga_2784.jpg';
% Ia = imread(fn_l);
% Ib = imread(fn_r);
% MatchThreshold = 0.9; %% no larger than 1
% NumPoints = 500; %% maximum preserved feature points
% [X, Y] = putative_match(Ia, Ib, NumPoints, MatchThreshold);
%% 
if size(Ia,3)==1
    Ia = repmat(Ia,[1,1,3]);
end
if size(Ib,3)==1
    Ib = repmat(Ib,[1,1,3]);
end
[wa,ha,~] = size(Ia);
[wb,hb,~] = size(Ib);
maxw = max(wa,wb);  maxh = max(ha,hb);
Ib(wb+1:maxw, :,:) = 0;
Ia(wa+1:maxw, :,:) = 0;

tic;
x1 = X; y1 = Y;
[numx1,~] = size(x1);
p1 = ones(1,numx1);
Xt = X';Yt = Y';
vec=Yt-Xt;
d2=vec(1,:).^2+vec(2,:).^2;
d_gc=mapminmax(d2, 0, 1);

%% constructe K-NN by kdtree
kdtreeX = vl_kdtreebuild(Xt);
kdtreeY = vl_kdtreebuild(Yt);  
[neighborX, ~] = vl_kdtreequery(kdtreeX, Xt, Xt, 'NumNeighbors', numNeigh+3) ;
[neighborY, ~] = vl_kdtreequery(kdtreeY, Yt, Yt, 'NumNeighbors', numNeigh+3) ;

%%% calculate the costs C and return binary vector p
[p2, C] = LPM_cosF(neighborX, neighborY, lambda, vec, d2, tau, numNeigh, r, d_gc, mu);
toc

%% show results
ind = find(p2 == 1);
if ~exist('CorrectIndex'), CorrectIndex = ind; end
[FP,FN] = plot_both(Ia, Ib, X, Y, ind, CorrectIndex);
[precise, recall, corrRate] = evaluate(CorrectIndex, ind, size(X,1));




