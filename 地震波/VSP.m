function VSP(P,x_xl,z_xl,t_xl,x0)
%��X��x0�����ܵ��ģ�z��t���ź�
if nargin==1
    x0=size(P,1);
end
[~,n,T]=size(P);
grd=reshape(P(x0,:,:),[n,T]);
ma=0.8e4;        %�����ɵ�
pcolor(z_xl,t_xl',grd'),shading interp,
xlabel('z/m'),ylabel('t/s'),view(0,-90),colorbar;
set(gca,'FontSize',16),caxis([-ma,ma]);
colormap(gray(201));
title(['Offset is ',num2str(x_xl(x0)),' m'])