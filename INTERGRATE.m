function [ ATMD_data,ROSE_data,IS_data ] = INTERGRATE( sdata ,whetherprint)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%INTEGRATE SECTION
%nature label
[sample,question]=size(sdata);
sex_data=sdata(:,1);
school_data=sdata(:,2);
grade_data=sdata(:,3);
%ATMD
pertaste_data=sdata(:,4)*3/2;
soctaste_data=sdata(:,5)*3/2;
beheffect_data=sdata(:,6)*3/2;
maneffect_data=sdata(:,7)*3/2;
goal_data=sdata(:,8)+sdata(:,9)+sdata(:,10);
plan_data=sdata(:,11)+sdata(:,12)+sdata(:,13);
priority_data=sdata(:,14)+sdata(:,15)+[6-sdata(:,16)];
feedback_data=sdata(:,17)+sdata(:,18)+sdata(:,19);
distribute_data=sdata(:,20)+sdata(:,21)+sdata(:,22);
ATMD_data=[pertaste_data+soctaste_data,beheffect_data+maneffect_data,goal_data,plan_data,priority_data,feedback_data,distribute_data];
%compass ande rose model
learn_data=sdata(:,23)+sdata(:,24)+sdata(:,25);
%score_data=[5-sdata(:,26)]*5/4+sdata(:,27)*5/4+[6-sdata(:,28)];
for i=1:1:sample
    if sdata(i,33)==4
        sdata(i,33)=1;
    else sdata(i,33)=sdata(i,33)+1;
    end
end
score_data=[[10-sdata(:,26)]*5/4-sdata(:,27)*5/4]*3/2;
live_data=[sdata(:,29)+sdata(:,30)]*3/2*5/4;
love_data=sdata(:,31)*5/4*3;
leave_data=zeros(sample,1);
for i=1:1:sample
    if sum(school_data(i)==[1,2,7])
        leave_data(i)=[5-sdata(i,32)+sdata(i,33)]*5/4*3/2;
    else
        leave_data(i)=[5-sdata(i,32)]*5/4+sdata(i,33)*5/4+sdata(i,28);
    end
end
iscadre_data=sdata(:,34);
isenrich_data=sdata(:,35);
ROSE_data=[learn_data,score_data,live_data,love_data,leave_data];
IS_data=[iscadre_data,isenrich_data];

if whetherprint==1
    XLSX=[pertaste_data,soctaste_data,beheffect_data,maneffect_data,goal_data,plan_data,priority_data,feedback_data,distribute_data,learn_data,score_data,live_data,love_data,leave_data];
    XLSX=[sex_data,school_data,grade_data,zscore(XLSX)];
    xlswrite('AMOS_data.xls',XLSX,'B2:R15048');
end
if whetherprint==2
    ATMD_data=[pertaste_data,soctaste_data,beheffect_data,maneffect_data,goal_data,plan_data,priority_data,feedback_data,distribute_data];
    ROSE_data=[learn_data,score_data,live_data,love_data,leave_data];
end
end

