function S=readstruct(filename,m,n,vmin,vmax,isadd)
% ��ȡ����ģ�ͣ�filenameΪ��ȡ��ͼƬ�ļ����ƣ���m��n��Ϊ��ȡ�ĵص�����Ľڵ���
% ��vmin��vmax��Ϊ��������������½��ޣ� isadd һ��ȡ ��1
imgray=(rgb2gray(imread(filename)))';
[M,N]=size(imgray);
x=floor(linspace(1,M,m));
y=floor(linspace(1,N,n));
S=imgray(x,y);
%imshow(S);
S=double(S)*isadd;
smax=max(max(S));
smin=min(min(S));
S=(vmax-vmin)/(smax-smin)*S+(vmax*smin-vmin*smax)/(smin-smax);


