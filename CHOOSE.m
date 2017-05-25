function [ goal_data ] = CHOOSE( sex,school,grade,source_data )
%   sex      [1,2]
%   school   [1,2,3,4,5,6,7]
%   grade    [1,2,3,4]
%   choose  
%%
%source_data= xlsread('4-21','SHEET1','G2:AO147');
[sample,question]=size(source_data);
%choose=[sex,grade,school];
%chsex=[1,2];
%chschool=[1,2,3,4,5,6,7];
%chgrade=[1,2,3,4];
%sex_data=source_data(:,1);
%school_data=source_data(:,2);
%grade_data=source_data(:,3);
%attribute_data=[sex_data,school_data,grade_data];
%%
goal_data=zeros(1,question);
j=0;
    for i=1:1:sample
            if (sum(source_data(i,1)==sex)&&sum(source_data(i,2)==school)&&sum(source_data(i,3)==grade))
                goal_data = [goal_data;source_data(i,:)];
            end        
    end
goal_data(1,:)=[];
end

