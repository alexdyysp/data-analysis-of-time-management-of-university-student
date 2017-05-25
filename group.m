clc,clear
sdata = xlsread('4-20','SHEET1','G2:AO15048');
[ ATMD_data,ROSE_data,IS_data ] = INTERGRATE( sdata ,0);
sdata=[sdata(:,1:3), ATMD_data,ROSE_data];
[ ATMD_ENTROPY , AENTROPY_WEIGHT ]=ENTROPY( ATMD_data );
[ ROSE_ENTROPY , RENTROPY_WEIGHT ]=ENTROPY( ROSE_data );
ATMD_ENTROPY=ATMD_data*AENTROPY_WEIGHT';ROSE_ENTROPY=ROSE_data*RENTROPY_WEIGHT';
%%
%SEX [1,2]
[ sex_data_1 ] = CHOOSE( [1],[1,2,3,4,5,6,7],[1,2,3,4],sdata );summary_1=sum(sex_data_1)/size(sex_data_1,1);
[ sex_data_2 ] = CHOOSE( [2],[1,2,3,4,5,6,7],[1,2,3,4],sdata );summary_2=sum(sex_data_2)/size(sex_data_2,1);
%%plot radar figure
PLOT_SEX=[summary_1(:,4:15);summary_2(:,4:15)];
%PLOT_SEX=mapminmax(PLOT_SEX,0,1);
Acluster=PLOT_SEX(:,1:7);Rcluster=PLOT_SEX(:,8:12);
Acluster=meanlize(Acluster,ATMD_data);Rcluster=meanlize(Rcluster,ROSE_data);
hold on
figure (1)
subplot(1,2,1),radarplot(Acluster,{'价值感','效能感','设置目标','计划','优先级','反馈性','时间分配'}),title('青少年时间管理倾向')
subplot(1,2,2),radarplot(Rcluster,{'学习','成绩','生活','爱','创造价值'}),title('罗盘玫瑰模型')
legend('男','女')
%%
%GRADE [1,2,3,4]
%sdata=[sdata(:,1:3),mapminmax(sdata(:,4:15),0.02,0.96)];
[ sdata_1 ] = CHOOSE( [1,2],[1,2,3,4,5,6,7],[1],sdata );summary_1=sum(sdata_1)/size(sdata_1,1);
[ sdata_2 ] = CHOOSE( [1,2],[1,2,3,4,5,6,7],[2],sdata );summary_2=sum(sdata_2)/size(sdata_2,1);
[ sdata_3 ] = CHOOSE( [1,2],[1,2,3,4,5,6,7],[3],sdata );summary_3=sum(sdata_3)/size(sdata_3,1);
[ sdata_4 ] = CHOOSE( [1,2],[1,2,3,4,5,6,7],[4],sdata );summary_4=sum(sdata_4)/size(sdata_4,1);
%%plot radar figure
PLOT=[summary_1(:,4:15);summary_2(:,4:15);summary_3(:,4:15);summary_4(:,4:15)];
PLOTmm=mapminmax(PLOT,0,1);
Acluster=PLOT(:,1:7);Rcluster=PLOT(:,8:12);
Acluster=meanlize(Acluster,ATMD_data);Rcluster=meanlize(Rcluster,ROSE_data);
Aclustermm=PLOT(:,1:7);Rclustermm=PLOT(:,8:12);
Aclustermm=mapminmax(Aclustermm,0,1);Rclustermm=mapminmax(Rclustermm,0,1);
%ENTROPY
E_A=Acluster*AENTROPY_WEIGHT';E_R=Rcluster*RENTROPY_WEIGHT';
EA_ALL_per = (E_A-min(ATMD_ENTROPY))/(max(ATMD_ENTROPY)-min(ATMD_ENTROPY))*100;
ER_ALL_per = (E_R-min(ROSE_ENTROPY))/(max(ROSE_ENTROPY)-min(ROSE_ENTROPY))*100;
hold on
figure (1)
subplot(1,2,1),radarplot(Acluster,{'价值感','效能感','设置目标','计划','优先级','反馈性','时间分配'}),title('青少年时间管理倾向')
subplot(1,2,2),radarplot(Rcluster,{'学习','成绩','生活','爱','创造价值'}),title('罗盘玫瑰模型')
legend('大一','大二','大三','大四')
%%
%School [1;2,7;3,4,5,6,]
[ school_1 ] = CHOOSE( [1,2],[1],[1,2,3,4],sdata );summary_1=sum(school_1)/size(school_1,1);
[ school_2 ] = CHOOSE( [1,2],[2,7],[1,2,3,4],sdata );summary_2=sum(school_2)/size(school_2,1);
[ school_3 ] = CHOOSE( [1,2],[3,4,5,6],[1,2,3,4],sdata );summary_3=sum(school_3)/size(school_3,1);
PLOT_school = [summary_1;summary_2;summary_3];
PLOT_school=PLOT_school(:,4:15);
%PLOT_school=mapminmax(PLOT_school,0,1);
Acluster=PLOT_school(:,1:7);Rcluster=PLOT_school(:,8:12);
Acluster=meanlize(Acluster,ATMD_data);Rcluster=meanlize(Rcluster,ROSE_data);
hold on
figure (1)
subplot(1,2,1),radarplot(Acluster,{'价值感','效能感','设置目标','计划','优先级','反馈性','时间分配'}),title('青少年时间管理倾向')
subplot(1,2,2),radarplot(Rcluster,{'学习','成绩','生活','爱','创造价值'}),title('罗盘玫瑰模型')
legend('一本','三本','大专')