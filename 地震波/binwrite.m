function binwrite(filename,P)
%�洢Ϊ�����Ƶ������ļ�
fid=fopen(filename,'wb');
fwrite(fid,P,'single');
fclose(fid);