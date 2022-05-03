function am=AM(R, F)

[M, N]=size(R);
sumR=sum(sum(R));
ER=sumR/(M*N);
ddR=(sumR-ER)^2/(M*N);
sumF=sum(sum(F));
EF=sumF/(M*N);
ddf=(sumF-EF)^2/(M*N);

[Rcouts, Rx]=imhist(R);
[Fcouts, Fx]=imhist(F);
n=length(Rx);
for i = 1:n
    HR=Rcouts(i);
    grayR=Rx(i);
    indexR=find(F==grayR);
    sigamaF=length(indexR)*grayR;
    ERF=sigamaF/HR;
    ddRF(i)=(sigamaF-ERF)^2/HR;
    pR(i)=HR/(M*N);

    HF=Fcouts(i);
    grayF=Fx(i);
    indexF=find(R==grayR);
    sigamaR=length(indexF)*grayF;
    ERR=sigamaR/HF;
    ddFR(i)=(sigamaR-ERR)^2/HF;
    pF(i)=HF/(M*N);
end

temp1=ddRF.*pR;
ddRF=sum(sum(temp1));
temp2=ddFR.*pF;
ddFR=sum(sum(temp2));
am=ddR*ddF/(ddRF*ddR+ddFR*ddF);