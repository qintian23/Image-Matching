%   This is a demo for removing outliers. In this demo, the SIFT matches
%   is known in advance.

if 1
    initialization;
%     addpath('C:\Users\Jiayi\Google Drive\code\new_data');
end
clear %all; % close all; 
rand('state', 1);

% configuration of VFC
normalize = 1;
visualize = 0;
conf.beta = 0.1;
conf.lambda = 1;
conf.a = 5;
if ~exist('conf', 'var'), conf = []; end
conf = VFC_init(conf);

mea=zeros(100,5);
err_vfc = zeros(100,98);
for jj = 1:1
    tt = 30;
%     if (jj==4) || (jj==5)
%         tt=20;
%     else
%         tt=100;
%     end
for ii = 1:100
    filename = ['save_fish_def_' num2str(jj) '_' num2str(ii) '.mat'];
    load(filename);
% load save_chinese_occlusion_2_3.mat
% load save_chinese_outlier_5_67.mat
% load save_fish_outlier_5_88.mat
% load save_fish_noise_3_2.mat
% load save_fish_outlier_3_2.mat
% load cpd_data2D_fish.mat
X=x1;
Y=y2a;
% tmp = X; X=Y; Y=tmp;

% configuration of SC
mean_dist_global=[]; % use [] to estimate scale from the data
nbins_theta=12;
nbins_r=5;
nsamp1=size(X,1);
nsamp2=size(Y,1);
ndum1=max(0, nsamp2-nsamp1);
ndum2=max(0, nsamp1-nsamp2);
eps_dum=0.15;
r_inner=1/8;
r_outer=2;
n_iter=tt;

if visualize
   figure(21)
   plot(X(:,1),X(:,2),'b+',Y(:,1),Y(:,2),'ro')
%    title(['original pointsets (nsamp1=' int2str(nsamp1) ', nsamp2=' ...
%        int2str(nsamp2) ')'])
   drawnow
   axis off
end

% initialize transformed version of model pointset
Xk=X; 
% initialize counter
k=1;
s=1;
% out_vec_{1,2} are indicator vectors for keeping track of estimated
% outliers on each iteration
out_vec_1=zeros(1,nsamp1); 
out_vec_2=zeros(1,nsamp2);

while s
%    disp(['iter=' int2str(k)])
   
   % compute shape contexts for (transformed) model
   [BH1,mean_dist_1]=sc_compute(Xk',zeros(1,nsamp1),mean_dist_global,nbins_theta,nbins_r,r_inner,r_outer,out_vec_1);

   % compute shape contexts for target, using the scale estimate from
   % the warped model
   % Note: this is necessary only because out_vec_2 can change on each
   % iteration, which affects the shape contexts.  Otherwise, Y does
   % not change.
   [BH2,mean_dist_2]=sc_compute(Y',zeros(1,nsamp2),mean_dist_1,nbins_theta,nbins_r,r_inner,r_outer,out_vec_2);

   % compute pairwise cost between all shape contexts
   costmat=hist_cost_2(BH1,BH2);
   % pad the cost matrix with costs for dummies
   nptsd=nsamp1+ndum1;
   costmat2=eps_dum*ones(nptsd,nptsd);
   costmat2(1:nsamp1,1:nsamp2)=costmat;
%    disp('running hungarian alg.')
   cvec=hungarian(costmat2);
%   cvec=hungarian_fast(costmat2);
   [a,cvec2]=sort(cvec);
%    disp('done.')
   
   X2 = Xk;
   Y2 = Y(cvec2(1:nsamp1),:);
   
   normal.xm=0; normal.ym=0;
   normal.xscale=1; normal.yscale=1;
   if normalize, [nX, nY, normal]=norm2(X2,Y2); end
   
   VecFld=VFC(nX, nY-nX, conf);
   if normalize, VecFld.V=(VecFld.V+nX)*normal.yscale+repmat(normal.ym,size(Y2,1),1)-X2; end 
   V = VecFld.V+X2;
   out_idx = setdiff(1:nsamp1, VecFld.VFCIndex);
%    out_vec_1(out_idx) = 1;
%    out_vec_2(cvec2(out_idx)) = 1;
%    out_vec_2(cvec2(nsamp1+1:end)) = 1;
   
   if visualize
      figure(22)
      plot(V(:,1),V(:,2),'b+',Y(:,1),Y(:,2),'ro')
      hold on
      h=plot([V(VecFld.VFCIndex,1) Y2(VecFld.VFCIndex,1)]',[V(VecFld.VFCIndex,2) Y2(VecFld.VFCIndex,2)]','k:');
      hold off
      axis off
%       title([int2str(length(VecFld.VFCIndex)) ' correspondences (warped X)'])
      drawnow	
   end
   
   if visualize
      figure(23)
      plot(V(:,1),V(:,2),'b+',Y(:,1),Y(:,2),'ro')
      hold on
      h=plot([V(VecFld.VFCIndex,1) Y2(VecFld.VFCIndex,1)]',[V(VecFld.VFCIndex,2) Y2(VecFld.VFCIndex,2)]','k-');
      hold off
      title([int2str(length(VecFld.VFCIndex)) ' correspondences (warped X)'])
      drawnow	
   end
   
   % update Xk for the next iteration
   Xk = V;
   
   % stop early if shape context score is sufficiently low
   if k==n_iter
      s=0;
   else
      k=k+1;
   end
end
% Y = y2;
if nsamp2>nsamp1
    Y = Y(1:nsamp1,:);
end
mea(ii,jj) = sum(sqrt(sum((Y-V).^2,2)))/size(Y,1);
err_vfc(ii,:) = sqrt(sum((Y-V).^2,2))';
fprintf('The %d-th group, %d-th sample, error: %f\n', jj, ii, mea(ii,jj));

end
end
mean(mea)
std(mea)

save('vfc_def.mat', 'mea')
