clc;clear;
chos=[7,8,10,13,12,11,5];
name=char('����(rho)','��(rho)','˫����(rho)','��б(rho)','�ϲ�(rho)','����(rho)','�౳б(rho)');

for i=1:length(chos)
[P,rho,V,K,input,x_xl,z_xl,t_xl]=seis_simul(200,200,1300,chos(i));
P=single(P);
save(name(i,:),'P','t_xl','x_xl','z_xl','K','input','rho','V');
end
 
%P(abs(P)<0.2e3)=0;