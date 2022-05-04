%   This is a demo for removing outliers. In this demo, the SIFT matches
%   is known in advance.

if 1
    initialization;
end
clear %all; % close all; 

for jj = 1:5
    for ii = 1:100
        filename1 = ['save_fish_outlier_' num2str(jj) '_' num2str(ii) '.mat'];
        filename2 = ['save_chinese_outlier_' num2str(jj) '_' num2str(ii) '.mat'];
        filename3 = ['../new_data/save_fi_chi_outlier_' num2str(jj) '_' num2str(ii) '.mat'];
        
        load(filename1);
        X1=x1;
        Y1=y2a;
        
        load(filename2);
        X2=x1;
        Y2=y2a;
        
        X = [X1; X2+[1*ones(size(X2,1), 1), zeros(size(X2,1), 1)]];
        Y = [Y1; Y2+[1*ones(size(Y2,1), 1), zeros(size(Y2,1), 1)]];

       figure(21)
       plot(X(:,1),X(:,2),'b+',Y(:,1),Y(:,2),'ro')
    %    title(['original pointsets (nsamp1=' int2str(nsamp1) ', nsamp2=' ...
    %        int2str(nsamp2) ')'])
       drawnow
       axis off
       save(filename3, 'X', 'Y');
    end
end
