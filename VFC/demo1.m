%   This is a demo for removing outliers.

% Authors: Jiayi Ma (jyma2010@gmail.com)
% Date:    04/17/2012

clear all; 
close all; 

% Read images
ImgName1 = 'church1.jpg' ;
ImgName2 = 'church2.jpg' ;
I1 = imread(ImgName1) ;
I2 = imread(ImgName2) ;

% Load data: initial correspondences and ground truth
load('church.mat');

% Data normalization
[nX, nY, normal]=norm2(X,Y);

% Initialization
conf.method = 'SparseVFC';
if ~exist('conf', 'var'), conf = []; end
conf = VFC_init(conf);

% Ourlier removal
tic;
switch conf.method
    case 'VFC'
        VecFld=VFC(nX, nY-nX, conf);
    case 'FastVFC'
        VecFld=FastVFC(nX, nY-nX, conf);
    case 'SparseVFC'
        VecFld=SparseVFC(nX, nY-nX, conf);
end
toc;

% Denormalization
VecFld.V=(VecFld.V+nX)*normal.yscale+repmat(normal.ym,size(Y,1),1)-X;

% Evaluation
if ~exist('CorrectIndex', 'var'), CorrectIndex = VecFld.VFCIndex; end
[precise, recall, corrRate] = evaluate(CorrectIndex, VecFld.VFCIndex, size(X,1));

% Plot results
plot_matches(I1, I2, X, Y, VecFld.VFCIndex, CorrectIndex);
