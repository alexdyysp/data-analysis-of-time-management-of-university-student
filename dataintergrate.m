clc;clear;
%variable
%   sample是样本数量
%   ATMD_data       时间管理调查表数据
%   ROSE_data       罗盘玫瑰模型数据
%   ATMD_CLUSTER    ATMD分类类别
%   ROSE_CLUSTER    ROSE分类类别
%   Acluster        ATMD分类数据
%   Rcluster        ROSE分类数据
%   ARcluster       ATMD与ROSE交叉各类成员数
%   EAcluster_per   ATMD信息熵
%   ERcluster_per   ROSE信息熵
%function 
%   INTERGRATE      整合数据    [ ATMD_data,ROSE_data,IS_data ] = INTERGRATE( sdata ,0)
%   ENTROPY         信息熵运算  [ ATMD_ENTROPY , AENTROPY_WEIGHT ]=ENTROPY( ATMD_data )
%   Kmeans          聚类分析    [ ATMD_CLUSTER , ATMD_C ] = Kmeans( ATMD_data )
%   CLUSSUM         聚类综合运算[ Acluster ] = CLUSSUM( ATMD_data , ATMD_CLUSTER)
%   radarplot       画雷达图    radarplot(Rcluster,{'学习','成绩','生活','爱','创造价值'}),title('罗盘玫瑰模型')
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
subplot(1,2,1),radarplot(Acluster,{'价值感','效能感','设置目标','计划','优先级','反馈性','时间分配'}),title('青少年时间管理倾向')
subplot(1,2,2),radarplot(Rcluster,{'学习','成绩','生活','爱','创造价值'}),title('罗盘玫瑰模型')
legend('A类','B类','C类','独立分类')
figure (2)
subplot(1,2,1),radarplot(A_ALL,{'价值感','效能感','设置目标','计划','优先级','反馈性','时间分配'}),title('青少年时间管理倾向')
subplot(1,2,2),radarplot(R_ALL,{'学习','成绩','生活','爱','创造价值'}),title('罗盘玫瑰模型')
legend('第一类','第二类','第三类','综合分类')
EAcluster_per
ERcluster_per
ARcluster_per