function [id,C]=test2(input,k)
%ϣ��һ��һ��ؾ��ࣨЯ����x����Ϣ������
[id,C]=kmeans(input,k);
j=1;
for i=1:k
    dff=diff(find(id==i));
    idn=find(dff>1);
    if ~isnan(idn) 
        %??/
    end
end