	%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%��������---�Ǿ��Ƚ��ʶ�ά��������(һ��ѹ��--�ٶ�)��2��ʱ���֡�2�׿ռ��־���
%%���ϱ߽�
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
close all;clear,clc
tic
%%***********************��ԴΪRicker�Ӳ�*********
dtt=0.0001;
tt=-0.06:dtt:0.06;
fm=30;
A=0.01;
wave=A*(1-2*(pi*fm*tt).^2).*exp(-(pi*fm*tt).^2);
plot(wave),title('��Դ�Ӳ�--Ricker�Ӳ�');
%%***********************************************
%% ģ�Ͳ�������
dz=5;         % ���������С����λm
dx=5;         % ���������С����λm
dt=0.0001;    % ʱ�䲽������λs
T=0.5;        % ��������ʱ�䣬��λs
wave(round(T/dt))=0;    % ���Ӳ����沿�ֲ���
% %% �о�����
% z=-750:dz:750;   x=-1000:dz:1000;
pml=50;          % ���ղ��������
plx=pml*dx;      % �������ղ�ĺ��
plz=pml*dz;      % �������ղ�ĺ��
z=-750-plz:dz:750+plz;   
x=-1000-plx:dx:1000+plx;  % ��������
n=length(z);     m=length(x);      % ��������
z0=round(n/2);   x0=round(m/2);    % ��Դλ��
Vmax=0;         % �ݲ�����ٶ�
 
%%Setting Velocity & Density
zt=-750-plz:dz/2:750+plz; 
xt=-1000-plx:dx/2:1000+plx;   % �ٶ����ܶȲ�������
nt=length(zt);     mt=length(xt);       % �ٶ����ܶȲ�������Ŀ
V=zeros(n,m);       % �����ٶ�,m/s
d=zeros(nt,mt);     % �����ܶ�,kg/m^3
 
%%���Ƚ���ģ��
for i=1:n
    for k=1:m
        V(i,k)=2.0e3;
    end
end
for i=1:n
    for k=1:m
        d(2*i,2*k)=2.3e3;
    end
end
 
% % %%��״����ģ��
% % for i=1:n
% %     for k=1:m
% %         if i < round(n/3)
% %             V(i,k)=2.3e3;
% %         else
% %             V(i,k)=3.0e3;
% %         end
% %     end
% % end
for i=1:n-1
    for k=1:m-1
        d(2*i+1,2*k)=(d(2*i,2*k)+d(2*(i+1),2*k))/2;
        d(2*i,2*k+1)=(d(2*i,2*k)+d(2*i,2*(k+1)))/2;
    end
end
for i=1:n
    for k=1:m
        if V(i,k) > Vmax
            Vmax=V(i,k);
        end
    end
end
%%**********************˥��ϵ��************************
%% ddx��ddz ����x�����z�����˥��ϵ��
R=1e-6;          % ���۷���ϵ��
ddx=zeros(n,m); ddz=zeros(n,m);
 
for i=1:n
    for k=1:m
        %% ����1
        if i>=1 & i<=pml & k>=1 & k<=pml
            x=pml-k;z=pml-i;
            ddx(i,k)=-log(R)*3*Vmax*x^2/(2*plx^2);
            ddz(i,k)=-log(R)*3*Vmax*z^2/(2*plz^2);
        elseif i>=1 & i<=pml & k>m-pml & k<=m
            x=k-(m-pml);z=pml-i;
            ddx(i,k)=-log(R)*3*Vmax*x^2/(2*plx^2);
            ddz(i,k)=-log(R)*3*Vmax*z^2/(2*plz^2);
        elseif i>n-pml & i<=n & k>=1 & k<=pml
            x=pml-k;z=i-(n-pml);
            ddx(i,k)=-log(R)*3*Vmax*x^2/(2*plx^2);
            ddz(i,k)=-log(R)*3*Vmax*z^2/(2*plz^2);
        elseif i>n-pml & i<=n & k>m-pml & k<=m
            x=k-(m-pml);z=i-(n-pml);
            ddx(i,k)=-log(R)*3*Vmax*x^2/(2*plx^2);
            ddz(i,k)=-log(R)*3*Vmax*z^2/(2*plz^2);
        %% ����2
        elseif i<=pml & k>pml & k<m-pml+1
            x=0;z=pml-i;
            ddx(i,k)=0;ddz(i,k)=-log(R)*3*Vmax*z^2/(2*plz^2);
        elseif  i>n-pml & i<=n & k>pml & k<=m-pml
            x=0;z=i-(n-pml);
            ddx(i,k)=0;ddz(i,k)=-log(R)*3*Vmax*z^2/(2*plz^2);
        %% ����3
        elseif i>pml & i<=n-pml & k<=pml
            x=pml-k;z=0;
            ddx(i,k)=-log(R)*3*Vmax*x^2/(2*plx^2);ddz(i,k)=0;
        elseif i>pml & i<=n-pml & k>m-pml & k<=m
            x=k-(m-pml);z=0;
            ddx(i,k)=-log(R)*3*Vmax*x^2/(2*plx^2);ddz(i,k)=0;
        end
    end
end
% figure(1),imagesc(ddz),title('z����˥��ϵ��');
% figure(2),imagesc(ddx),title('x����˥��ϵ��');
%%**************************************************
%%**********************����ģ��********************
p0=zeros(n,m);    p1=zeros(n,m);
px0=zeros(n,m);   px1=zeros(n,m);
pz0=zeros(n,m);   pz1=zeros(n,m);
K=zeros(n,m);     
Vx1=zeros(nt,mt); Vx0=zeros(nt,mt);
Vz1=zeros(nt,mt); Vz0=zeros(nt,mt);
 
for t=dt:dt:T
    p0(z0,x0)=dt*V(z0,x0)^2*wave(round(t/dt));
    for i=2:n-1
        for k=2:m-1
            K(i,k)=d(2*i,2*k)*V(i,k)^2;
            Vz1(2*i+1,2*k)=((1-0.5*dt*ddz(i,k))*Vz0(2*i+1,2*k)-dt*(p0(i+1,k)-p0(i,k))/(d(2*i+1,2*k)*dz))/(1+0.5*dt*ddz(i,k));
            Vx1(2*i,2*k+1)=((1-0.5*dt*ddx(i,k))*Vx0(2*i,2*k+1)-dt*(p0(i,k+1)-p0(i,k))/(d(2*i,2*k+1)*dx))/(1+0.5*dt*ddx(i,k));
            
            pz1(i,k)=((1-0.5*dt*ddz(i,k))*pz0(i,k)-K(i,k)*dt*(Vz1(2*i+1,2*k)-Vz1(2*i-1,2*k))/dz)/(1+0.5*dt*ddz(i,k));
            px1(i,k)=((1-0.5*dt*ddx(i,k))*px0(i,k)-K(i,k)*dt*(Vx1(2*i,2*k+1)-Vx1(2*i,2*k-1))/dx)/(1+0.5*dt*ddx(i,k)); 
            
            p1(i,k)=px1(i,k)+pz1(i,k);
        end
    end
    p0=p1;
    pz0=pz1;px0=px1;
    Vz0=Vz1;Vx0=Vx1;
    for i=1:n-2*pml
        for k=1:m-2*pml
            p(i,k)=p1(i+pml,k+pml);
        end
    end
     imagesc(p1),title('��������'),pause(0.0000001);
end
figure(1),imagesc(p1);title('��������--��������2��');
figure(2),imagesc(p);title('��������--�������񡢼ӱ߽�');
% figure(2),imagesc(pz1);title('z����');
% figure(3),imagesc(px1);title('x����');
%%*************************************************
