function F=trafre(A)
% ��P��ʱ����ת��ΪƵ��
[m,n,t]=size(A);
F=zeros(m,n,t);
for i=1:m
    for j=1:n
        F(i,j,:)=fft(A(i,j,:));
    end
end