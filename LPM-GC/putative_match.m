function [X,Y]=putative_match(Ia,Ib,NumPoints,matchThreshold)

if size(Ia,3)~=1
    I1=rgb2gray(Ia);
else
    I1=Ia;
end
if size(Ib,3)~=1
    I2=rgb2gray(Ib);
else
    I2=Ib;
end

points1=detectSURFFeatures(I1);
points1=points1.selectStrongest(NumPoints);X1=points1.Location;
points2=detectSURFFeatures(I2);
points2=points2.selectStrongest(NumPoints);X2=points2.Location;

[features1,vp1]=extractFeatures(I1,points1,'Method','SURF');
[features2,vp2]=extractFeatures(I2,points2,'Method','SURF');

[matchIndex,distance]=matchFeatures(features1,features2,'Method','Approximate','MatchThreshold',100,'MaxRatio',matchThreshold);

X=X1(matchIndex(:,1),:);
Y=X2(matchIndex(:,2),:);
