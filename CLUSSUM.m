function [ CASE_cluster ] = CLUSSUM( DATA , CLUSTER)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
CASE=size(DATA);
first_cluster=zeros(CASE);second_cluster=zeros(CASE);third_cluster=zeros(CASE);
C1=0;C2=0;C3=0;
for i=1:1:CASE(1)
    if CLUSTER(i)==1
        first_cluster(i,:)=DATA(i,:);
        C1=C1+1;
    end
    if CLUSTER(i)==2
        second_cluster(i,:)=DATA(i,:);
        C2=C2+1;
    end
    if CLUSTER(i)==3
        third_cluster(i,:)=DATA(i,:);
        C3=C3+1;
    end    
end
CASE_cluster=[sum(first_cluster)/C1;sum(second_cluster)/C2;sum(third_cluster)/C3];
end

