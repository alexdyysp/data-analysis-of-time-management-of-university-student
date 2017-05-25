clc;clear;
%variable
%   sample����������
%   ATMD_data       ʱ�������������
%   ROSE_data       ����õ��ģ������
%   ATMD_CLUSTER    ATMD�������
%   ROSE_CLUSTER    ROSE�������
%   Acluster        ATMD��������
%   Rcluster        ROSE��������
%   ARcluster       ATMD��ROSE��������Ա��
%   EAcluster_per   ATMD��Ϣ��
%   ERcluster_per   ROSE��Ϣ��
%function 
%   INTERGRATE      ��������    [ ATMD_data,ROSE_data,IS_data ] = INTERGRATE( sdata ,0)
%   ENTROPY         ��Ϣ������  [ ATMD_ENTROPY , AENTROPY_WEIGHT ]=ENTROPY( ATMD_data )
%   Kmeans          �������    [ ATMD_CLUSTER , ATMD_C ] = Kmeans( ATMD_data )
%   CLUSSUM         �����ۺ�����[ Acluster ] = CLUSSUM( ATMD_data , ATMD_CLUSTER)
%   radarplot       ���״�ͼ    radarplot(Rcluster,{'ѧϰ','�ɼ�','����','��','�����ֵ'}),title('����õ��ģ��')
%%
%READ SOURCE DATA
%sdata=[1	2	3	5	5	4	5	3	2	5	5	4	1	4	5	3	2	2	1	3	5	5	4	5	2	2	3	-3	2	2	2	3	1	2	4;
%    1	2	3	5	5	4	5	3	2	5	5	4	1	4	5	3	2	2	1	3	5	5	4	5	2	2	3	-3	2	2	2	3	1	2	4;
%    1	2	3	5	5	4	5	3	2	5	5	4	1	4	5	3	2	2	1	3	5	5	4	5	2	2	3	-3	2	2	2	3	1	2	4];
sdata = xlsread('4-20','SHEET1','G2:AO15048');
%[ sdata ] = CHOOSE( [1,2],[3,4,5,6],[1,2,3,4],sdata );
%[ sdata ] = CHOOSE( [1,2],[3,4,5,6],[1,2,3,4],sdata );
%%
%INTEGRATE SECTION
[ ATMD_data,ROSE_data,IS_data ] = INTERGRATE( sdata ,0);
[sample,question]=size(sdata);
%%
%KMEAN CLUSING
%initialte
CASE_ATMD=size(ATMD_data);CASE_ROSE=size(ROSE_data);
[ ATMD_CLUSTER , ATMD_C ] = Kmeans( ATMD_data );
[ ROSE_CLUSTER , ROSE_C ] = Kmeans( ROSE_data );
[ ATMD_ENTROPY , AENTROPY_WEIGHT ]=ENTROPY( ATMD_data );
[ ROSE_ENTROPY , RENTROPY_WEIGHT ]=ENTROPY( ROSE_data );
%ALL CLUSTER
[ ALL_CLUSTER , ALL_C ] = Kmeans( [ATMD_data,ROSE_data] );
%%
%CLUSTER CACULATING
%ATMD
[ Acluster ] = CLUSSUM( ATMD_data , ATMD_CLUSTER);
[ EAcluster ] = CLUSSUM( ATMD_ENTROPY , ATMD_CLUSTER);
EAcluster_per = (EAcluster-min(ATMD_ENTROPY))/(max(ATMD_ENTROPY)-min(ATMD_ENTROPY))*100;
%ROSE
[ Rcluster ] = CLUSSUM( ROSE_data , ROSE_CLUSTER);
[ ERcluster ] = CLUSSUM( ROSE_ENTROPY , ROSE_CLUSTER);
ERcluster_per = (ERcluster-min(ROSE_ENTROPY))/(max(ROSE_ENTROPY)-min(ROSE_ENTROPY))*100;
%ATMD&ROSE
ARcluster=zeros(3,3);
for i=1:1:sample
            ARcluster(ATMD_CLUSTER(i),ROSE_CLUSTER(i))= ARcluster(ATMD_CLUSTER(i),ROSE_CLUSTER(i))+1;
end
ARcluster_per=ARcluster/sample*100;
%%ALL
%ATMD
[ A_ALL ] = CLUSSUM( ATMD_data , ALL_CLUSTER);
[ EA_ALL ] = CLUSSUM( ATMD_ENTROPY , ALL_CLUSTER);
EA_ALL_per = (EA_ALL-min(ATMD_ENTROPY))/(max(ATMD_ENTROPY)-min(ATMD_ENTROPY))*100;
%ROSE
[ R_ALL ] = CLUSSUM( ROSE_data , ALL_CLUSTER);
[ ER_ALL ] = CLUSSUM( ROSE_ENTROPY , ALL_CLUSTER);
ER_ALL_per = (ER_ALL-min(ROSE_ENTROPY))/(max(ROSE_ENTROPY)-min(ROSE_ENTROPY))*100;
%%plot radar figure
hold on
figure (1)
subplot(1,2,1),radarplot(Acluster,{'��ֵ��','Ч�ܸ�','����Ŀ��','�ƻ�','���ȼ�','������','ʱ�����'}),title('������ʱ���������')
subplot(1,2,2),radarplot(Rcluster,{'ѧϰ','�ɼ�','����','��','�����ֵ'}),title('����õ��ģ��')
legend('A��','B��','C��','��������')
figure (2)
subplot(1,2,1),radarplot(A_ALL,{'��ֵ��','Ч�ܸ�','����Ŀ��','�ƻ�','���ȼ�','������','ʱ�����'}),title('������ʱ���������')
subplot(1,2,2),radarplot(R_ALL,{'ѧϰ','�ɼ�','����','��','�����ֵ'}),title('����õ��ģ��')
legend('��һ��','�ڶ���','������','�ۺϷ���')
EAcluster_per
ERcluster_per
ARcluster_per